pipeline {
    agent { label 'agent1' }

    triggers {
        // Run the pipeline daily at midnight
        cron('H H * * *')
    }

    environment {
        GITHUB_REPO = 'https://github.com/AndriiKhomik/java-fullstack.git'
    }

    stages {
        stage('Set Build Display Name') {
            steps {
                script {
                    // Set custom display name
                    def branch = env.GIT_BRANCH
                    currentBuild.displayName = "#${BUILD_NUMBER}, branch ${branch}"
                }
            }
        }
        stage('Checkout') {
            steps {
                // Checkout source code from Github
                git branch: 'dev', url: "${env.GITHUB_REPO}"
            }
        }
        stage('Test') {
            steps {
                // Test application
                echo 'Testing...'
            }
        }
        stage('Build') {
            steps {
                // Run build
                echo 'Building the application...'
                sh 'mvn clean package'
            }
        }
        stage('Deploy') {
            steps {
                // Deploy application
                echo 'Deploying the application'
            }
        }
    }

    post {
        success {
            echo 'Deployment succeeded!'
        }
        failure {
            echo 'Deployment failed'
        }
    }
}