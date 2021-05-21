DevOps task

   this document will help explain step by step how to solve this task 
   note** all configuration and installation did for amazon services 

   u can git all foles via: 
            https://github.com/SarahRefaat/finalTask.git
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

======================================================================================================
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

