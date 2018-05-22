properties([
    parameters([ 
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
    ])
])

node {
    stage('Build') {
        checkout scm
        echo "SQL UPDATE FOR: ${params.title}" 
        echo "email: ${params.email}"
        echo "note: ${params.note}"
    }
    stage('Generating New REQ') {
        def reqName = sh scripts: 'bin/nextReq.sh', returnStdout: true
    }

}