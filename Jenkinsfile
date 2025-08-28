pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'indrasena23/samplejavacode:latest'
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds' // exact Jenkins credential ID
        KUBECONFIG_CREDENTIALS = 'kubeconfig-creds' // Jenkins credential ID for kubeconfig file
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out source code...'
                git branch: 'master', url: 'http://github.com/indra25cloud/SaiJavaCode.git'
            }
        }

        stage('Build Maven Projects') {
            steps {
                echo 'Building Maven projects...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image ${DOCKER_IMAGE}..."
                sh 'cp webapp/target/webapp.war .'
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker image ${DOCKER_IMAGE} to DockerHub..."
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                script {
                    // Use kubeconfig stored in Jenkins credentials
                    withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS, variable: 'KUBECONFIG_FILE')]) {
                        sh 'export KUBECONFIG=$KUBECONFIG_FILE'
                        sh 'kubectl apply -f k8s/deployment.yaml'
                        sh 'kubectl rollout status deployment/my-app-deployment'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed! Check the logs.'
        }
    }
}
