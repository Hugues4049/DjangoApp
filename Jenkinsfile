pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('debe861c-53ab-4400-a9c6-3faba5330e82') // Remplacez par l'ID de vos credentials DockerHub
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
                sh 'docker login -u hugues4049 -p TITOroland#4049'
                sh 'docker tag hugues4049/my_django_app hugues4049/my_django_app:latest'
                sh 'docker push hugues4049/my_django_app:latest'
            }
        }

        stage('Deploy to Server (optional)') {
            steps {
                // Ici vous pouvez ajouter une étape pour déployer l'application dans un environnement
                // comme Kubernetes, AWS ECS, ou même un serveur en production.
                echo 'Déploiement sur le serveur non configuré hello'
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
