pipeline {
    agent { label 'agent1' }

    environment {
        GITHUB_REPO = 'https://github.com/AndriiKhomik/java-fullstack.git'
    }

    tools {
        nodejs 'NodeJS 14.x'
        gradle 'Gradle 7.5'
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
                sh 'gradle test'
            }
        }
        stage('Build Backend') {
            steps {
                // Run build
                echo 'Building the application...'
                sh 'gradle build -x test'
                // sh "docker build -t andriikhomik/java-fullstack:backend-${BUILD_NUMBER} -t andriikhomik/java-fullstack:backend-latest ."
            }
        }
        stage('Build Frontend') {
            steps {
                script {
                    dir('frontend') {
                        // Run build
                        echo 'Building the frontend application...'
                        // sh 'npm install'
                        // sh 'npm run build'
                        // sh "docker build -t andriikhomik/java-fullstack:frontend-${BUILD_NUMBER} -t andriikhomik/java-fullstack:frontend-latest ."
                    }
                }

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