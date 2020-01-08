pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'mvn test'
      }
    }

    stage('test') {
      steps {
        echo 'test'
      }
    }

    stage('end') {
      steps {
        sleep(time: 4, unit: 'SECONDS')
      }
    }

  }
}