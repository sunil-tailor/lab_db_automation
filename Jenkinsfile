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
        name: 'note',
        defaultValue: 'Just a quick summary about this update',
        description: 'Any extra summary information'
    )        
])])

node {
    stage('Build') {
        checkout scm
        echo "SQL UPDATE FOR: ${params.title}" 
        echo "email: ${params.email}"
        echo "note: ${params.note}"
    }
    stage('Generating New REQ Branch') {
        def reqName = sh script: 'bin/createNewReqBranch.sh', returnStdout: true
        echo "output: ${reqName}"

        def contents = ''
        contents = contents + "title=" + $(params.title) + "\n"
        contents = contents + "email=" + $(params.email) + "\n"
        contents = contents + "note=" + $(params.note) + "\n"

        def filename = "./updates/${reqName}/metadata.properties"
        writeFile file: filename, text: contents


    }

}