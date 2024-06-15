# This is a comprehensive overview on how to create a pipeline with Jenkins while using SonarQube for code Analysis, Docker for image build and push , and Openshift to deploy our app .
![image](https://github.com/Yousrry/Ivolve/assets/172133196/a2c6afb8-e687-4041-8e1b-2e1d8fc30d5f)

## Project Architecture

### The architecture of this project includes:

### - AWS: Used for infrastructure provisioning and management.
### - Terraform: Infrastructure as Code (IaC) tool for managing AWS resources.
### - Ansible: Configuration management and application deployment tool.
### - SonarQube: Static-review Used for code Analysis to ensure the code quality
### - Docker: Containerization platform to build and run applications.
### - OpenShift: Container orchestration platform for deploying Dockerized applications.
### - Jenkins: CI/CD tool for automating the build, test, and deployment process.


## First Is Terraform !

### We should always provision our resources as a first step of any project and we do that by using terraform, I have used modules and variables to make the scripts as clean and reuseable as possible ! 
![Screenshot from 2024-06-14 10-27-46](https://github.com/Yousrry/Ivolve/assets/172133196/45686d2c-9bad-4a43-9bf0-29f26862fe56)
![Screenshot from 2024-06-14 10-28-00](https://github.com/Yousrry/Ivolve/assets/172133196/adfb2968-67e3-4f71-a01a-dc9ac35278e5)
### and after the first apply we un-comment the following backend section to enable remote backend and re-apply

![Screenshot from 2024-06-14 10-31-36](https://github.com/Yousrry/Ivolve/assets/172133196/dfd27c11-d65e-4da2-b6f8-cf2d11d7a747)

![Screenshot from 2024-06-14 10-32-18](https://github.com/Yousrry/Ivolve/assets/172133196/f08dafbd-b4c6-4d55-8e8c-9ab4e502559c)
### we then check  AWS console to ensure resources provisioned correctly 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/0ebebf91-64ed-4954-811b-c7d0a186f2d4)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/3873731c-2a19-42e8-89cc-fab2dee92748)
### We check our mointoring Module 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/8ac7fe57-0064-4bd7-b4b7-cdc7eeaeb962)

![image](https://github.com/Yousrry/Ivolve/assets/172133196/6bdae481-a898-45ed-bd5f-fb8935a97c92)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/3df75227-5bb1-4e52-a8ce-3a319fb2d6f0)
### also note thet the resources for remote backend has been provisioned with server side encryption and versioning enabled on the s3 ! 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/6d06b992-efc6-4f2b-8ed0-ba235b58c4c8)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/ce40e5e9-d6aa-46ed-a61d-67da1392e7ea)

## key points to note while using terraform 
### - when provisioning the EC2 make sure to give it enough space (atleast 20 GB),and give it the pre-made key name to be able to access it later !

![image](https://github.com/Yousrry/Ivolve/assets/172133196/c0c68d84-c926-47ee-8123-2183b84fef37)
### - when provisioning the VPC make sure to enable DNS as later we will use Ansible dynamic inventory which requires puplic DNS
![image](https://github.com/Yousrry/Ivolve/assets/172133196/f85357b7-761b-4725-81c0-96c9cbd911c2)


## Next stop is Ansible ! 
### after provisioning resources we need to configure them ,and that's why we need Ansible ! 
### we need to install the plugin called aws_ec2 which helps in in creating Dynamic inventory for EC2 instances 
# (inventory)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/ff01627a-b8a8-4484-aa7e-04b772d5eba2)
# (ansible.cfg) 
### "note we're using the same key we used with EC2"
![image](https://github.com/Yousrry/Ivolve/assets/172133196/b0317107-9795-42e2-83d3-4069645fd1b6)

### Next we use Ansible roles to configura each of our tools ! 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/bf08a153-1bdb-4ff5-b16d-3b21266bfe8e)
```
├── Docker_role
│   ├── defaults
│   │   └── main.yml
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
├── jenkins_role
│   ├── defaults
│   │   └── main.yml
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
├── OC-role
│   ├── defaults
│   │   └── main.yml
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
├── postgresql
│   ├── defaults
│   │   └── main.yml
│   ├── files
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── templates
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
└── SonarQube-role
    ├── defaults
    │   └── main.yml
    ├── files
    │   └── sonarqube.service
    ├── handlers
    │   └── main.yml
    ├── meta
    │   └── main.yml
    ├── README.md
    ├── tasks
    │   └── main.yml
    ├── templates
    │   └── sonar.properties.j2
    ├── tests
    │   ├── inventory
    │   └── test.yml
    └── vars
        └── main.yml
```

### Finally , The playbook where we call upon all the roles! 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/6e8a82ff-866c-49dc-bb77-943eb569c640)

### We run the playbook and wait for the confirmation that all tasks were made !
![Screenshot from 2024-06-14 11-01-05](https://github.com/Yousrry/Ivolve/assets/172133196/0eda7367-6577-4ce3-aebb-38673f48c48c)


## Third Is SonarQube ! 
### we now need to configure sonarqube service after it has been created and started by ansible ! 
### the initial user name and password are both admin 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/61cae65c-2b26-478c-811e-2dfaa28327ec)

### but don't worry you're asked to change that at the start xD
![image](https://github.com/Yousrry/Ivolve/assets/172133196/ed811f7b-915e-47e0-9470-9925a61b8f6e)

### We then create a project and a token !  those will be used later when integrating with jenkins.
![image](https://github.com/Yousrry/Ivolve/assets/172133196/eb042fe9-7b43-4715-9e21-91dffab83844)
### We need to change build.gradle file and add sonarqube plugin 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/9064c9a8-a531-485d-81c7-1ac7cfdab304)


### after the pipeline is successful we see our code review 

## Fourth is Docker !

### There is nothing much to do with Docker it was installed and configured with Ansible 
### we only need the dockerhub credentials for jenkins integration ! 


## Then comes Openshift ! 

### we need to create the following : Service account , Role , Role-binding , Secret . in order to optain the token necessary for jenkins integration ! 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/a7c53bdf-f36b-44b9-9b9c-4497452e0011)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/18ceb681-eb29-4f3b-bb86-c67965e689d5)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/0db7397c-8212-48ee-97ff-99f17c466dc3)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/1077a8a9-8e6b-40cc-a0ea-e4164df609e7)
### we then use the secret to get the token ! 
![Screenshot from 2024-06-14 11-12-32](https://github.com/Yousrry/Ivolve/assets/172133196/7ec25d49-f636-463f-9444-0d8a84342e00)

## Finally we're ready for jenkins ! 
### jenkins was installed and configured with ansible , and ansible gave us the initial password as seen 
![Screenshot from 2024-06-14 11-04-39](https://github.com/Yousrry/Ivolve/assets/172133196/72942dd6-6fbd-41f0-912a-b43393813e1d)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/271d3b9b-7d76-4015-b4b8-efb347001c1e)

### we login to jenkins and install the required plugins Called Sonarqube scanner 
### we then set up credentials ! 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/56763d98-9683-4fe2-9ef3-1db4f5dfb6d0)
### we need 4 credentials in total ! 
#### - DockerHub is used to push the image 
#### - Openshift is used to sign in the cluster 
#### - Sonarqube is used to connect to sonarqube server 
#### - github is used to connect to github and pull the app 

### we then set up shared library and create the pipeline ! 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/7ab84505-85d5-47ed-bb28-fc53de18a89d)

### Finally we run the pipeline , we hopefully se a success like this ! 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/6f19cf38-80cc-4e85-bef4-aeffc78bbc09)
### checking the sonarqube server for the code review 
![image](https://github.com/Yousrry/Ivolve/assets/172133196/6e4fee4e-8891-40e3-86ec-e55a8e79e2ae)

### checking the OC cluster for the app 
![Screenshot from 2024-06-14 12-41-20](https://github.com/Yousrry/Ivolve/assets/172133196/25c87822-9412-4b70-b6e8-6f8ccdff32cf)
![image](https://github.com/Yousrry/Ivolve/assets/172133196/af632d00-7a2a-4e32-b3ea-f88e8e49b66e)


### accessing the app 
![Screenshot from 2024-06-14 12-42-19](https://github.com/Yousrry/Ivolve/assets/172133196/2d6acd67-ffdd-4c5d-8b21-86a099ff04e8)
![Screenshot from 2024-06-14 12-46-22](https://github.com/Yousrry/Ivolve/assets/172133196/3a3dc959-802d-4056-99bf-8e31bbb88f86)

# And that's it ! the project is done and the app is reviewd and deployed ! 
# Don't forget to terraform destroy ! 





