pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "jujudevops"
        DOCKER_IMAGE_NAME = "jujudevops/abc-technologies"
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
        DOCKER_PORT = "8888"
    }
    
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    def dockerfile = """
                        FROM tomcat:9-jre8
                        EXPOSE ${DOCKER_PORT}
                        ENV TOMCAT_USER=admin
                        ENV TOMCAT_PASSWORD=password
                        ENV WAR_FILE=ABCTechologies 1.0.war
                        COPY ABCTechologies 1.0.war /usr/local/tomcat/webapps/
                        ADD deploy.sh /usr/local/tomcat/bin/
                        RUN chmod +x /usr/local/tomcat/bin/deploy.sh
                        CMD ["/usr/local/tomcat/bin/deploy.sh"]
                    """
                    sh 'sudo docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} -'
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'f347aa87-41e5-40ab-b0e4-51ca2b46a34b', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    script {
                        sh "docker login -u ${DOCKER_REGISTRY} -p ${DOCKERHUB_PASSWORD}"
                        sh "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    }
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    sh "docker run -d -p ${DOCKER_PORT}:${DOCKER_PORT} -e TOMCAT_USER=admin -e TOMCAT_PASSWORD=password -e WAR_FILE=ABCTechologies 1.0.war ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }
    }
}
