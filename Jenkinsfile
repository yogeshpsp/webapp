pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
               sh 'docker system prune --all'
            }
        }
    }
}
