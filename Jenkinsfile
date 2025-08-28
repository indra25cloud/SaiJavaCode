pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-creds'  // Exact Jenkins credentials ID
        DOCKER_IMAGE = 'indrasena23/samplejavacode:latest'
        MAVEN_OPTS = '-Dmaven.test.skip=true'       // Skip tests if desired
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out source code from GitHub...'
                git branch: 'main', url: 'https://github.com/yourusername/CICD-Project.git'
            }
        }

        stage('Build Maven Projects') {
            steps {
                echo 'Building Maven projects...'
                sh 'mvn clean package'
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
                // Uncomment and customize below for your deployment
                // sh 'kubectl apply -f k8s/deployment.yaml'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for errors.'
        }
    }
}
