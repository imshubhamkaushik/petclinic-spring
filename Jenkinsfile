pipeline{
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'mvn clean install'
                    } else {
                        bat 'mvn clean install'
                    }
                }
            }
        }
        stage('test') {
            steps {
                script {
                    if (isUnix()) {
                        sh 'test'
                    }
                }
            }
        }
    }
}