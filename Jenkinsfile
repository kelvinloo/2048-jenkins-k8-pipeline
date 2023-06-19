pipeline {

  environment {
    dockerimagename = "kelvinlctd/2048game"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git credentialsId: 'github-credentials', url: 'https://github.com/kelvinloo/-jenkins-kubernetes-deployment-.git', branch: 'main'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Deploying 2048 game') {
      steps {
        script{
          bat "kubectl apply -f 2048.yaml"
        }
           
      }
      
    }

  }

}