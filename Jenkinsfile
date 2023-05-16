pipeline {
  agent any
  stages {
    stage('Clone a repo') {
      steps {
        sh 'git clone https://github.com/DevOpsQueen/Test4.git'
      }
    }

    stage('Build and package') {
      steps {
        sh ''' dir(\'ABCTechnologies\') {
                    withEnv([\'PATH+MAVEN=/usr/bin\']) {
                        sh \'mvn package\''''
        }
      }

    }
  }