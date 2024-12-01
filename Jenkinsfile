pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REPO = '<aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/nti-project'
        KUBECONFIG = '/path/to/kubeconfig'
        DOCKER_IMAGE_FRONTEND = "${ECR_REPO}-frontend:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
        DOCKER_IMAGE_BACKEND = "${ECR_REPO}-backend:${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build Docker Image for Frontend') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE_FRONTEND, './frontend')
                }
            }
        }

        stage('Build Docker Image for Backend') {
            steps {
                script {
                    docker.build(DOCKER_IMAGE_BACKEND, './backend')
                }
            }
        }

        stage('Push Docker Images to ECR') {
            steps {
                script {
                    withAWS(region: "${AWS_DEFAULT_REGION}", credentials: 'aws-credentials-id') {
                        sh '''
                            aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ECR_REPO
                            docker push $DOCKER_IMAGE_FRONTEND
                            docker push $DOCKER_IMAGE_BACKEND
                        '''
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                        kubectl set image deployment/frontend frontend=$DOCKER_IMAGE_FRONTEND --kubeconfig=$KUBECONFIG
                        kubectl set image deployment/backend backend=$DOCKER_IMAGE_BACKEND --kubeconfig=$KUBECONFIG
                        kubectl rollout status deployment/frontend --kubeconfig=$KUBECONFIG
                        kubectl rollout status deployment/backend --kubeconfig=$KUBECONFIG
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}
