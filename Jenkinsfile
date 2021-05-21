List<String> CHOICES = ["prod","test","dev","release"]
pipeline {
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
                    dockerImage = docker build -< Dockerfile -t 3.82.203.20:9000/repository/my-repo:$BUILD_NUMBER 
                    withCredentials([usernamePassword(credentialsId: 'nexus', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                     sh "login -u $USERNAME -p $PASSWORD http://3.82.203.20:9000" 
                     sh "docker push $dockerImage"
                   }
                }           
                //else if (params.CHOICE == "dev"||params.CHOICE == "test"||params.CHOICE == "prod"){
               // sh "kubectl create ns "$params.CHOICE""
               // sh "git checkout "$param.CHOICE""
                // sh "kubectl apply -f deployment.yaml -n "$param.CHOICE""
                // sh "kubectl apply -f service.yaml -n "$param.CHOICE""
                //}
              }
           }
        }
      }
    }
