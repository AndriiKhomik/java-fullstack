pipeline {
    agent { label 'agent1' }

    triggers {
        // Run the pipeline daily at midnight
        cron('H H * * *')
        // Trigger the pipeline on changes in the GitHub repository
        pollSCM('* * * * *')
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
                    wrap([$class: 'BuildUser']) {
                        echo "${env.BUILD_USER_ID}, ${env.BUILD_USER}, ${env.BUILD_USER_FIRST_NAME} , ${env.BUILD_USER_LAST_NAME}, ${env.BUILD_USER_GROUPS}, ${env.BUILD_USER_EMAIL}"
                    }
                    currentBuild.displayName = "#${BUILD_NUMBER}, branch ${branch}, triggered by ${env.BUILD_USER}"
                }
            }
        }
        stage('Checkout') {
            steps {
                // Checkout source code from Github
                git branch: 'dev', url: "${env.GITHUB_REPO}"
            }
        }
        stage('Build') {
            steps {
                // Run build
                echo 'Building the application...'
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