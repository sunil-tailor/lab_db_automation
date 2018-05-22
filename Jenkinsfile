#!groovy

pipeline {
    agent any
    parameters {
        string(
            name: 'title',
            defaultValue: 'test title',
            description: 'Title for SQL update'
        )
        string(
            name: 'email',
            defaultValue: 'joe.boggs@test.com',
            description: 'email addresses separated by comma'
        )
        string(
            name: 'note',
            defaultValue: 'Just a quick summary about this update',
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
                sh 'bin/nextReq.sh > result'
                def reqCode = readFile('result').split("\r?\n")

                sh '''
                echo "REQ CODE: " + reqName
                echo "SQL UPDATE FOR: "+ $(params.title)
                def contents = ''
                contents = contents + "title=" + $(params.title) + "\n"
                contents = contents + "email=" + $(params.email) + "\n"
                contents = contents + "note=" + $(params.note) + "\n"

                echo contents
                '''
            }
        }
    }
}

