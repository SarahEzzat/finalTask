List<String> CHOICES = ["prod","test","dev","release"]
pipeline {
    environment { 
        registry = "sacpc/jen" 
        registryCredential = 'sacpc' 
        dockerImage = '' 
    }
    agent any 
     parameters{
      choice(name: 'CHOICE' , choices: CHOICES, description: 'which branch to configure')
     }
    stages {
        
          stage('Set Credentials') {
             steps{
             withAWS(credentials: 'sara.refaat') {
                 sh "aws eks --region us-east-1 update-kubeconfig --name test"
               }
              }
             }
          stage('Set Kube Credentials') {
             steps{
             withCredentials([file(credentialsId: 'kube-eks', variable: 'KUBECONFIG')]){
              sh "kubectl get deployments"
              }
             }        
           }  
          stage('Build according to choosed branch'){
            steps{
              script{
                if(params.CHOICE == "release"){
                    git 'https://github.com/SarahRefaat/finalTask'
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push()
                  } 
                }
                else if (params.CHOICE == "dev"||params.CHOICE == "test"||params.CHOICE == "prod"){
                 sh "kubectl create ns "$params.CHOICE""
                 sh "git checkout "$param.CHOICE""
                 sh "kubectl apply -f deployment.yaml -n "$param.CHOICE""
                 sh "kubectl apply -f service.yaml -n "$param.CHOICE""
                }
              }
           }
        }
      }
    }
