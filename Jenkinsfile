pipeline {
    agent any
    environment {
        //DOCKER_USERNAME = "${credentials('docker-hub-credentials').username}"
        //DOCKER_PASSWORD = "${credentials('docker-hub-credentials').password}"
        DOCKER_REGISTRY = "https://registry.hub.docker.com" // Aktualisieren Sie die URL des Docker-Registrierungsservers
        DOCKER_CREDENTIALS = 'docker-hub-credentials' // Ihr Credential ID
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Can-24/spring-petclinic.git'
            }
        }

        stage('Build and Package Spring PetClinic') {
            steps {
                bat 'mvn clean package'
            }
        }
        /*stage('Docker Build'){
            agent any
            steps {
                bat 'docker build -t can24/spring-petclinic:latest .'
            }
        }
        */
        stage('Publish Docker Image') {
            steps {
                script {
                    def dockerImage
                    // Docker-Build und Tag des Images
                    dockerImage = docker.build("can24/spring-petclinic:${env.BUILD_ID}")
                    // Docker-Login und Push
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        docker.withRegistry(env.DOCKER_REGISTRY, env.DOCKER_CREDENTIALS) {
                            dockerImage.push()
                        }
                    }
                }
            }
        }
    }
}