pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "indrasena23/samplejavacode:latest"
        DOCKERHUB_CREDENTIALS = "dockerhub-credentials-id" // Replace with your Jenkins credentials ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/indra25cloud/SaiJavaCode.git', branch: 'master'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'cp webapp/target/webapp.war .'
                script {
                    docker.build(DOCKER_IMAGE)
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploy to Kubernetes stage - Add your kubectl commands here"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
    }
}
