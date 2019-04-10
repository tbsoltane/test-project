node('docker') {

stage('Initialize')
    {
        def dockerHome = tool 'Docker'
        def mavenHome  = tool 'Default Maven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }

stage('Checkout'){

checkout scm
}

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
        
        def customImage = docker.build("my-image:${env.BUILD_ID}")
        
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




