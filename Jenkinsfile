pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git(branch: 'main', url: 'https://github.com/Can-24/spring-petclinic.git')
      }
    }

    stage('Build and Package Spring PetClinic') {
      steps {
        bat 'mvn clean package'
      }
    }

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
  environment {
    DOCKER_REGISTRY = 'https://registry.hub.docker.com'
    DOCKER_CREDENTIALS = 'docker-hub-credentials'
  }
}