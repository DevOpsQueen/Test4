pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/DevOpsQueen/Test4.git'
            }
        }

        stage('Build and package') {
            steps {
                dir('ABCTechnologies') {
                    withEnv(['PATH+MAVEN=/usr/bin']) {
                        sh 'mvn package'
                    }
                }
            }
        }

        stage('Deploy to Tomcat') {
            environment {
                TOMCAT_HOST = '192.168.1.10' // Replace with the actual IP address or hostname of your Tomcat server
            }
            steps {
                withCredentials([
                    usernamePassword(credentialsId: 'be813074-4ae4-4087-8cc3-fa414f5f7aa0', passwordVariable: 'TOMCAT_PASSWORD', usernameVariable: 'TOMCAT_USERNAME')
                ]) {
                    script {
                        def tomcatUsername = env.TOMCAT_USERNAME
                        def tomcatPassword = env.TOMCAT_PASSWORD
                        def tomcatHost = env.TOMCAT_HOST
                        
                        sh '''
                            sshpass -p '${tomcatPassword}' scp -o StrictHostKeyChecking=no ABCTechnologies/target/ABCtechnologies-1.0.war '${tomcatUsername}'@'${tomcatHost}':/opt/tomcat/webapps
                        '''
                    }
                }
            }
        }
    }
}
