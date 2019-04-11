node {

   def app

stage('Initialize')
    {
        def dockerHome = tool 'Docker'
        def mavenHome  = tool 'Default Maven'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }

stage('Checkout'){

checkout scm
}

/* environment {
    registry = "tbsoltane/docker-test"
    registryCredential = 'my-dockerhub-credentials'
    dockerImage = ''
  } */

stage('build') {
    withMaven(jdk: 'Default Java', maven: 'Default Maven') {
        /* .. some comment .. */
    sh 'mvn clean install'
}
}

stage('Building image') {
        
      /*  app = docker.build("tbsoltane:mavenapp") */
        app = docker.build("mytestimg:${env.BUILD_ID}")
        
    }
    

stage('push Image') {
         
            docker.withRegistry('https://registry.hub.docker.com', 'my-dockerhub-credentials') {
          /*  app.push("${env.BUILD_NUMBER}")
            app.push("latest") */
            app.push(latest)
          
         }
        
    }
    


/* stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }*/
  
}




