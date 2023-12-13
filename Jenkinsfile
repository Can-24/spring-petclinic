pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        script {
          git(
            url: 'https://github.com/Can-24/spring-petclinic.git',
            branch: 'main',
            credentialsId: 'github_1',
            directory: "${DESKTOP_PATH}/spring-petclinic-1"
          )
        }

      }
    }

    stage('Build and Package Spring PetClinic') {
      steps {
        script {
          dir('C:\\Users\\Can\\Desktop\\spring-petclinic-1') {
            //Fuehre Maven-Build aus
            bat 'mvn clean package'
          }
        }

      }
    }

    stage('Build & Publish Docker Image') {
      steps {
        script {
          def dockerImage
          // Docker-Build und Tag des Images
          dir("${DESKTOP_PATH}/spring-petclinic-1") {
            dockerImage = docker.build("can24/spring-petclinic:${env.BUILD_ID}", "-f Dockerfile .")
          }
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
    DESKTOP_PATH = 'C:\\Users\\Can\\Desktop'
  }
}