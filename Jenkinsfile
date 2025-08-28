pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')   // Jenkins credential ID
    DOCKER_IMAGE = "indrasena23/samplejavacode:latest"         // Replace with your DockerHub username if different
  }

  stages {
    stage('Checkout Code') {
      steps {
        git url: 'https://github.com/indra25cloud/SaiJavaCode.git', branch: 'main'
      }
    }

    stage('Build with Maven') {
      steps {
        sh 'mvn clean package -DskipTests'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t $DOCKER_IMAGE .'
      }
    }

    stage('Push Docker Image') {
      steps {
        withDockerRegistry([ credentialsId: 'dockerhub-creds', url: '' ]) {
          sh 'docker push $DOCKER_IMAGE'
        }
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        script {
          // Try rolling update if deployment exists, else create new
          sh '''
          if kubectl get deployment saijavacode-deployment > /dev/null 2>&1; then
            kubectl set image deployment/saijavacode-deployment saijavacode=$DOCKER_IMAGE --record
          else
            kubectl apply -f k8s/deployment.yaml
            kubectl apply -f k8s/service.yaml
          fi
          '''
        }
      }
    }
  }
}
