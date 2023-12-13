pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git(url: 'https://github.com/Can-24/spring-petclinic.git', branch: 'main')
      }
    }

    stage('Build and Package Spring PetClinic') {
      steps {
        script {
          // �ndere tempor�r das Arbeitsverzeichnis
          dir('C:\\Users\\Can\\Desktop\\spring-petclinic-1') {
            //F�hre Maven-Build aus
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
    DOCKER_REGISTRY = '"https://registry.hub.docker.com"'
    DOCKER_CREDENTIALS = '\'docker-hub-credentials\''
  }
}