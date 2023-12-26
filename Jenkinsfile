pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
                cleanWs()
               sh 'docker system prune --all'
            }
        }
    }
}
