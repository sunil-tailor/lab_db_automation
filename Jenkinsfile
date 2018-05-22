#!groovy

pipeline {
    agent any
    parameters {
        string(name: 'Greeting', defaultValue: 'Hello', description: 'How should I greet the world?')
        string(
            title: '',
            defaultValue: '',
            description: 'Title for SQL update'
        )
        string(
            email: '',
            defaultValue: '',
            description: 'email addresses separated by comma'
        )
        string(
            note: '',
            defaultValue: '',
            description: 'Any extra summary information'
        )
                
    }
    stages {
        stage('Creating Template') {
            node {
                def reqName = sh scripts: 'bin/nextReq.sh', returnStdout: true

                echo "SQL UPDATE FOR: "+ $(params.title)
                def contents = ''
                contents = contents + "title=" + $(params.title) + "\n"
                contents = contents + "email=" + $(params.email) + "\n"
                contents = contents + "note=" + $(params.note) + "\n"

                echo contents
                
            }
        }
    }
}

