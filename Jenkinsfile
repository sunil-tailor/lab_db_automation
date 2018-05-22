#!groovy

pipeline {
    agent any
    parameters {
        string(
            name: 'title',
            defaultValue: '',
            description: 'Title for SQL update'
        )
        string(
            name: 'email',
            defaultValue: '',
            description: 'email addresses separated by comma'
        )
        string(
            name: 'note',
            defaultValue: '',
            description: 'Any extra summary information'
        )
                
    }
    stages {
        stage ('Clone Project') {
            steps {
                git 'https://github.com/sunil-tailor/lab_db_automation'
            }

        }
        stage ('Creating Template') {
            steps {
                def reqName = sh scripts: 'bin/nextReq.sh', returnStdout: true
                echo "REQ CODE: " + reqName
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

