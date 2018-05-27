#!groovy

import java.text.SimpleDateFormat




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
    def methodName(req) { 
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
    stage('Preparation') {

    }
    stage('checkout') {
        checkout([
            $class: 'GitSCM',
            branches: scm.branches,
            extensions: scm.extensions + [[$class: 'LocalBranch'], [$class: 'WipeWorkspace']],
            userRemoteConfigs: [ [aec45e23-c5aa-4ddd-8a0f-63a21d20191f], [ 'git@github.com:sunil-tailor/lab_db_automation.git' ]]
        ])

        sh "git config -g user.email \"jenkins@indexfeed.com\""
        sh "git config -g user.name \"Jenkins User\""
    }   
    stage('Creating NEW Branch REQ') {
        sh 'chmod 755 ./bin/*.sh'
        // def reqCode = sh( script: 'bin/state-nextReq.sh', returnStdout: true ).trim()
        
        def currentReqCode = sh('ls -1 updates/ | sort -V | tail -n 1)').trim()

        if (${currentReqCode} == '') {
            println "its blank"
        }

        // def reqName = sh( script: 'bin/createNewReqBranch.sh', returnStdout: true ).trim()

        echo "DEBUG: NewCode: ${currentReqCode}"
        echo "DEBUG: reqCode: ${reqCode}"
        echo "DEBUG: reqName: ${reqName}"

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
}