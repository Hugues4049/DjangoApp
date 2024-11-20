pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('identifiants_dockerhub') // Remplacez par l'ID de vos credentials DockerHub
        AWS_CREDENTIALS = credentials('aws_credentials_id')  // AWS credentials ID
    }

    stages {
        stage('Checkout code') {
            steps {
                // Cloner le dépôt Git
                git 'https://github.com/Hugues4049/DjangoApp.git'
            }
        }

       
        stage('Build Docker image') {
            steps {
                // Construire l'image Docker à partir du Dockerfile
                sh 'docker build -t my_django_app .'
            }
        }


        stage('Run Tests') {
            steps {
                // Exécuter les tests unitaires Django
                sh 'docker run --rm my_django_app sh -c "python manage.py test"'
            }
        }



        stage('Push to DockerHub') {
            steps {
                // Se connecter à DockerHub et pousser l'image
                sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
                sh 'docker tag hugues4049/my_django_app hugues4049/my_django_app:latest'
                sh 'docker push hugues4049/my_django_app:latest'
            }
        }


        stage('Login to ECR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'AWS_CREDENTIALS', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    // Log in to Amazon ECR
                    script {
                        def ecrRepoUrl = sh(script: 'terraform output -raw ecr_repository_url', returnStdout: true).trim()
                        sh """
                        aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ecrRepoUrl
                        """
                    }
                }
            }
        }

        stage('Tag and Push Docker Image to ECR') {
            steps {
                script {
                    def ecrRepoUrl = sh(script: 'terraform output -raw ecr_repository_url', returnStdout: true).trim()
                    // Tag the Docker image with the ECR repository URI
                    sh """
                    docker tag my_django_app:latest $ecrRepoUrl:latest
                    docker push $ecrRepoUrl:latest
                    """
                }
            }
        }
        
        stage('Terraform Init and Apply') {
            steps {
                dir('IAC') {
                    withCredentials([usernamePassword(credentialsId: 'AWS_CREDENTIALS', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        // Initialize and apply Terraform configuration
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

       

        stage('Deploy to AWS ECS') {
            steps {
                // Déployer l'application sur AWS ECS en mettant à jour le service ECS avec la nouvelle image Docker
                withCredentials([usernamePassword(credentialsId: 'AWS_CREDENTIALS', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                    aws ecs update-service \
                    --cluster <your-ecs-cluster-name> \
                    --service <your-ecs-service-name> \
                    --force-new-deployment \
                    --region <your-aws-region>
                    '''
                }
            }
        }
    }

    post {
        always {
            // Actions à effectuer, que le pipeline réussisse ou échoue
            cleanWs()  // Nettoyer l'espace de travail Jenkins
        }
    }
}
