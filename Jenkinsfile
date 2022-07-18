pipeline {
    agent any

    triggers {
        pollSCM('*/3 * * * *')
    }

    environment {
        imagename = "hkmvueimg"
        registryCredential = 'dochkm'
        dockerImage = ''
    }

    stages {
        // git���� repository clone
        stage('Prepare') {
          steps {
            echo 'Clonning Repository'
            git url: 'https://github.com/happym92/hkmvue.git',
              branch: 'master',
              credentialsId: 'githkm'
            }
            post {
             success { 
               echo 'Successfully Cloned Repository'
             }
           	 failure {
               error 'This pipeline stops here...'
             }
          }
        }
        
        stage('dockerizing'){
            steps{
                sh 'docker build -t devpgang/hkmvue .'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker stop hkmvue'
/               sh 'docker rm hkmvue'
                sh 'docker run -d -p 8092:8091 --name hkmvue devpgang/hkmvue'
            }

            post {
                success {
                    echo 'success'
                }

                failure {
                    echo 'failed'
                }
            }
        }
    }
}

