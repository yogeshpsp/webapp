pipeline {
    agent {
      Dockerfile true
    }

    stages {
        stage('Hello') {
            steps {
                bat 'docker version'
            }
        }
    }
}
