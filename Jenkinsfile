pipeline {
    agent { label 'agent1' }

    environment {
        GITHUB_REPO = 'https://github.com/AndriiKhomik/java-fullstack.git'
    }

    tools {
        nodejs 'NodeJS 14.x'
    }

    stages {
        stage('Set Build Display Name') {
            steps {
                script {
                    // Set custom display name
                    currentBuild.displayName = "#${BUILD_NUMBER}, branch ${env.GIT_BRANCH}"
                }
            }
        }
        stage('Checkout') {
            steps {
                // Checkout source code from Github
                checkout scm
            }
        }
        stage('Test') {
            steps {
                // Test application
                echo 'Testing...'
            }
        }
        stage('Build Frontend') {
            steps {
                script {
                    dir('frontend') {
                        // Run build
                        echo 'Building the frontend application...'
                        sh 'npm install'
                        sh 'npm run build'
                    }
                }

            }
        }
        stage('Build Backend') {
            steps {
                // Run build
                echo 'Building the application...'
                // sh 'mvn clean package'
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