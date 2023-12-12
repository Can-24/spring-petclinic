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
        bat 'mvn clean package'
      }
    }

  }
  environment {
    DOCKER_REGISTRY = '"https://registry.hub.docker.com"'
    DOCKER_CREDENTIALS = '\'docker-hub-credentials\''
  }
}