DevOps task

   this document will help explain step by step how to solve this task 
   note** all configuration and installation did for amazon services 

   u can git all foles via: 
            https://github.com/SarahRefaat/finalTask.git
 
a- terraform

1) u need to install terraform :
   
   
   wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
   sudo apt-get install zip -y
   unzip terraform*.zip
   sudo mv terraform /usr/local/bin

2) u need to create dir for ur work then run :

    
    terraformm init 

3) what files include :           

  - 000-provider :
 
              includes service provider details (aws,gcp,azure) and region of wanted resources .
  
  - 00-backend :
 
               which includes referance to .tfstate track of metadata and map of real resouces.

  - 00-variables :

               includes declearation of vars 
  
  - 0-variable :

               includes values of vars , which u can change as u want                 

  - 1-vpc :
              creating vpc 
  
  - 2-igw :
           
              includes creating of internet gateway which acts as gateway for ur vpc

  - 3-subnets :
     
              includes subnets where eks will allocate its nodes , don't forget to allow public ip assign

  - 4-rtbs :
    
               where u can set different routes rules for different subnets then u will need to assosciate subnets to those route tables
            
  - 5-roleApermissions :
       
                to create eks u need to have to service roles one for eks cluster anthor for ec2 nodes 
   
  - sg : 
      
               that creates security group with specif roles to allow 80, 8080 , 22 just main servcies
         note**:

  - sshkey :
   
                creates public and private key to use it later to ssh to ur instance by default u we get it in ur home "myKey.pem"

  - 7-eks :
      
                creates eks using different resouces 
          note**: using depends_on to make sure roles and permission will be built first
  
  - 8-nodes :
          
                 creates nodes u can controller their capacity using varibles file
          note**: using depends_on to make sure roles and permission will be built first

======================================================================
b- ansible

   
1) install ansible :
       
        sudo apt-add-repository ppa:ansible/ansible
        sudo apt update
        sudo apt install ansible

2) u need to edit /etc/ansible/ansible.cfg with ur params like:
   
        remote_user = ec2-user
   note**: amazon-linux default user
        private_key_file = /home/ubuntu/myKey.pem
        inventory      = /etc/ansible/hosts
   note**: don't forget to put them into [defaults] section 

3) edit ur inventory file in with ur /etc/ansible/hosts below [k8snodes] :
    
      add ur nodes ip

4) then create ur different roles each role represent wanted app :
   
    note**:  u can split taks to be more useable for future apps
          :  don't forget all those configs for EC2 AMAZON SERVICES 

5) calling  different roles in configtools.yaml 

6) IMPORTANT NOTES OF INSTALLED APPS :
  
     -  u can cat /var/lib/jenkins/secrets/initialAdminPassword   
                for ur first jenkins login, don't forget to use sudo :)
     -  u need to cat /opt/nexus/sonatype-work/nexus3/admin.password
                for ur first nexus login then set ur new password
     -  for sonarqube default credentials are :
                username : admin
                password : admin

=========================================================
c- pipline 


1) using installed jenkins , php shopping cart app (main product)


   note**: to apply the concept of ci/cd ur code must be release, if okay and done upload it to master
         : we have three branches for three stapes :
                - dev
                - test
                - prod
         : we deploy our code to deployment within the name of target stage
         
2) file on branch ci/cd :
    
      - build image using our app then push it to nexus
        HOW ??

   - u will need first to create hosted repo :
        here its name is my-repo 

   - then set allow http with whatever free port :
        here it is 9000

   note** : many steps tp apply pushing to nexus correctly
          
          - dont forget to login coz default docker registry is dockerhub
          - dont forget to tag image with link of repo name as jenkins file did
          - dont forget to allow Docker token in nexus from settings > Releams
          - u can allow https in case u used ssl certificate 
          - u need to create  sudo nano /etc/docker/daemon.json file and add ur {host:port} like that :
               { "insecure-registries":["localhost:9000"] }
          - then don't forget to run :  
               systemctl daemon-reload
               systemctl restart nexus
   
          - once image pushed u can see it using url of repo

        - in the second stage u need to install aws credential plugin in jenkins
           HOW ??
    
    - mange jenkins > plugins > avaiable > install > retsrat after installing
    
    - manage jenkins > mange credentials > jenkins > add credentials > 
       type : aws crediential
       key id : XXxXXXX
       secret key : XXXXXXXX
    *** ID : sara.refaat     >>> thats the id which u will use to call credentials in groovy
      NOTE** : to get ur key id and secret key u need to visit amazon servies > iam > security credentials > create key > download ur .crv file or just copy ur key id and secret key to safe place
    - configure kubectl using :
        curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
        chmod +x ./kubectl
        echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
        
    - from the same concept go to ur cluster and find .kube/kube.config
      u will find it on ur homw cat the file copy it and add u credential with type file then paste config content DONT FORGET TO SET ID 
    
3) there will be a build with parameter on the left of jenkins dashboard use it to test diff envs


NOTES** : dont forget to add webhooks on ur repo git to build once something new is pushed to the repo
        - ur-repo > settings > webhooks > add > url <of ur jenkins//github-webhook/> update 
               u can choose whether json or x-www-form-urlencoded : feel free to choose the readable one for u


hope all is clear and enjoy :)
               

