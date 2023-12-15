pipeline {
    agent {
      dockerfile true
    }

    stages {
        stage('Hello') {
            steps {
                bat 'docker version'
            }
        }
    }
}
