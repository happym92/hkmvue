pipeline {
    agent any

    triggers {
        pollSCM('*/3 * * * *')
    }

    environment {
        imagename = "zzicoyo"
        registryCredential = 'dochkm' // 레파지토리 옮긴후 재설정
        dockerImage = ''
    }

    stages {
        // git���� repository clone
        stage('Prepare') {
          steps {
            echo 'Clonning Repository'
            git url: 'https://github.com/happym92/zzic-oyo-front.git', // 레파지토리 옮긴후 재설정
              branch: 'master',
              credentialsId: 'githkm' // 레파지토리 옮긴후 재설정
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
                sh 'docker stop zzicfront'
                sh 'docker rm zzicfront'
                sh 'docker run -d -p 8092:8091 --name zzicfront devpgang/hkmvue'
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

