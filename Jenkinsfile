List<String> CHOICES = ["prod","test","dev","release"]
pipeline {
    environment { 
        registey = "http://3.82.203.20:8081/repository/my-repo/"
        registryCredential = 'nexus' 
        dockerImage = '' 
    }
    agent any 
     parameters{
      choice(name: 'CHOICE' , choices: CHOICES, description: 'which branch to configure')
     }
    stages {  
          stage('Build according to choosed branch'){
            steps{
              script{
                if(params.CHOICE == "release"){
                    git 'https://github.com/SarahRefaat/finalTask'
                    dockerImage = docker.build "nexus-image-:$BUILD_NUMBER" 
                    withCredentials([usernamePassword(credentialsId: 'nexus')]){
                      sh "sudo docker push $registey/dockerImage"
                   }
                }           
                #else if (params.CHOICE == "dev"||params.CHOICE == "test"||params.CHOICE == "prod"){
                # sh "kubectl create ns "$params.CHOICE""
                # sh "git checkout "$param.CHOICE""
                # sh "kubectl apply -f deployment.yaml -n "$param.CHOICE""
                # sh "kubectl apply -f service.yaml -n "$param.CHOICE""
                #}
              }
           }
        }
      }
    }
