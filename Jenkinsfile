#!groovy

import java.text.SimpleDateFormat

def nextReqCode(req) { 
    // Method code goes here 
    def dateFormat = new SimpleDateFormat("yyyyMMddHHmmss")
    def date = new Date()
    def newTS = dateFormat.format(date)

    (code, tag, ts) = req.split('-')
    def int num = code as Integer
    def newNum = num + 1
    def reqCode = newNum.toString().padLeft(5, '0') 

    return "${reqCode}-${tag}-${newTS}"
}

def newReqCode  = ''

properties([parameters([ 
    string(
        name: 'title',
        defaultValue: 'test title',
        description: 'Title for SQL update'
    ),
    string(
        name: 'email',
        defaultValue: 'joe.boggs@test.com',
        description: 'email addresses separated by comma'
    ),
    string(
        name: 'releaseTags',
        defaultValue: 'br18.04',
        description: 'tags, for target release'
    ),
    string(
        name: 'note',
        defaultValue: 'Just a quick summary about this update',
        description: 'Any extra summary information'
    )        
])])

node {
    stage('Cleaning Workspace') {
        deleteDir()
    }
    stage('Pre-Build Checks') {
        try {
            if (params.title == '') {
                echo "Jenkins - Build Failure - No 'title' was provided"
                currentBuild.result = 'FAILURE'
            }
            if (params.email == '') {
                echo "Jenkins - Build Failure - No 'email' was provided"
                currentBuild.result = 'FAILURE'
            }
            if (params.releaseTags == '') {
                echo "Jenkins - Build Failure - No 'release tag(s)' were provided"
                currentBuild.result = 'FAILURE'
            }
            else {
                currentBuild.result = 'SUCCESS'
            }
        } catch (Exception err) {
            currentBuild.result = 'FAILURE'
        }

        echo "Build Result: ${currentBuild.result}"
        echo "title: ${params.title}"
        echo "email: ${params.email}"
        echo "note: ${params.note}"
        echo "Release Tags: ${params.releaseTags}"
    }
    stage('checkout') {
        checkout([
            $class: 'GitSCM',
            branches: scm.branches,
            extensions: scm.extensions + [[$class: 'LocalBranch'], [$class: 'WipeWorkspace']],
            // userRemoteConfigs: [ [ credentialsId: 'aec45e23-c5aa-4ddd-8a0f-63a21d20191f', url: 'git@github.com:sunil-tailor/lab_db_automation.git' ]]
            userRemoteConfigs: [ [ credentialsId: 'jenkins', url: 'git@github.com:sunil-tailor/lab_db_automation.git' ]]
        ])
    }   
    stage('Creating NEW Branch REQ Code') {
        sh 'chmod 755 ./bin/*.sh'

        // Initialised state folder
        if (fileExists('state/initalised')) {
            echo 'Yes - system initalised'
            def currentReqCode = sh( script: 'cat state/requests.txt | tail -n 1', returnStdout: true )
            newReqCode = nextReqCode( currentReqCode )

            echo "DEBUG: currentReqCode  : ${currentReqCode}"
            echo "DEBUG: newReqCode      : ${newReqCode}"      

            sh "git checkout master"
            sh "git config user.email \"jenkins@indexfeed.com\""
            sh "git config user.name \"Jenkins User\""
            sh "echo ${newReqCode} >> state/requests.txt"
            sh "git commit -am 'created new REQ'"

            // Pushing everything to remote repository
            sshagent( credentials: ['jenkins'] ) {
                sh "git push origin master"
            }
        } else {
            currentBuild.result = 'FAILURE'
            echo 'System - You need to run the ./bin/initialise.sh and commit to repository'
        }

/*
        // def reqCode = sh( script: 'bin/state-nextReq.sh', returnStdout: true ).trim()
        def currentReqCode = null        
        $currentReqCode = sh( script: 'ls -1 updates/ | sort -V | tail -n 1', returnStdout: true )

        echo "TEST -- ${currentReqCode}"
        echo $currentReqCode.toString() 

        if (currentReqCode.toString() == '') {
            echo "its blank"
            $currentReqCode = '00001-CBO-00000000000000'
            def newReqCode = nextReqCode($currentReqCode)
            echo "DEBUG: currentReqCode  : ${currentReqCode}"
            echo "DEBUG: newReqCode      : ${newReqCode}"
        } else {
            def newReqCode = nextReqCode($currentReqCode)
            echo "DEBUG: currentReqCode  : ${currentReqCode}"
            echo "DEBUG: newReqCode      : ${newReqCode}"
        }
*/

        // def reqName = sh( script: 'bin/createNewReqBranch.sh', returnStdout: true ).trim()
        // echo "DEBUG: reqCode         : ${reqCode}"
        // echo "DEBUG: reqName         : ${reqName}"

        // Create properties file with metadata
/*  
        def contents = ''
        contents = contents + 'title="' + $(params.title) +''"\n"''
        contents = contents + "email=\"$(params.email)\"\n"
        contents = contents + "releaseTags=\"$(params.releaseTags)\"\n" 
        if (params.note == '') {
            contents = contents + "note=\"$(params.note)\"\n" 
        }

        def filename = "./updates/${reqName}/metadata.properties"
        writeFile file: ${filename}, text: contents
*/

    }
    stage('Generated Branch') { 
        
        (code, tag, ts) = newReqCode.split('-') 
        def branchName = "REQ-${newReqCode}"

        echo "code        : ${code}"
        echo "tag         : ${tag}"
        echo "timestamp   : ${ts}"
        echo "branch Name : ${branchName}"
        
        sh "git checkout -b ${branchName}"

        def sqlText = "# SQL file filename is the order in which scripts are executed"

        dir ("./updates/${branchName}/DEPLOY_SCRIPTS/") {
            writeFile file: "001-${ts}.sql", text: sqlText
            writeFile file: "002-${ts}.sql", text: sqlText
        }

        dir ("./updates/${branchName}/BACKOUT_SCRIPTS/") {
            writeFile file: "001-${ts}.sql", text: sqlText
            writeFile file: "002-${ts}.sql", text: sqlText
        }

        writeFile file: "./updates/${branchName}/README.md", text: ''

        // Create properties file with metadata
        def contents = ''
        contents = contents + "title=\"${params.title}\"\n"
        contents = contents + "email=\"${params.email}\"\n"
        contents = contents + "releaseTags=\"${params.releaseTags}\"\n"
        if (params.note != '') {
            contents = contents + "note=\"${params.note}\"\n"
        }

        writeFile file: "./updates/${branchName}/metadata.properties", text: contents

        // Add annotated tagging
        def tags = params.releaseTags.split(',')
        for (tag in tags) {
            tag = tag.trim()
            sh "git tag -a ${tag} -m \"${params.title}\""
        }

        sh "git add updates/${branchName}/*"
        sh "git commit -am 'First Commit for Branch ${branchName}'"

        // Pushing everything to remote repository
        sshagent( credentials: ['jenkins'] ) {
            sh "git push --set-upstream origin ${branchName}"
        }
    }
}