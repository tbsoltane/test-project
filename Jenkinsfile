node('docker') {
checkout scm
environment {
    registry = "tbsoltane/docker-test"
    registryCredential = 'my-dockerhub-credentials'
    dockerImage = ''
  }
stage('build') {
    withMaven(jdk: 'Default Java', maven: 'Default Maven') {
        /* .. some comment .. */
    sh 'mvn clean install'
}
}
stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }




