- Install jenkins using docker-compose.yml and run it in docker
```
version: '3.8'
services:
   jenkins:
     image: jenkins/jenkins
     ports:
     - 8080:8080
     - 50000:50000
     volumes:
     - jenkins_home:/var/jenkins_home
    
volumes:
     jenkins_home:

```
- Install Plugins
```
Install suggested plugins, also Docker and Build timestamp for current task
```

- Configure several 2 build agents. Agents must be run in docker

```
Create two ec2 instances
SSH to the instances
Use following commands
sudo nano /lib/systemd/system/docker.service
- Add the following lines in the both instances
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
sudo systemctl daemon-reload
sudo service docker restart
- Check the connection using command curl http://localhost:4243/version
- Goto Jenkins Manage Jenkins -> Manage Nodes and Clouds -> Configure Clouds -> Add a new cloud
- Add two agents 
```
- Create a Freestyle project. Which will show the current date as a result of execution.
```
- Goto Manage Jenkins -> Configure System and update Build Timestamp section
- Add GMT+4 in Timezone
- Create Freestyle project
- Specify newly added first docker agent label in 'Label Expression'
- Goto Build and choose 'Execute Shell'
- Write command "Current time $BUILD_TIMESTAMP'
- See Task4_output for console output
```
- Create Pipeline which will execute docker ps -a in docker agent, running on Jenkins master’s Host.
```
 - Goto New Item -> Pipeline
 - Add the following Script
 pipeline {
    agent { label 'docker-slave-2' }  
    stages {
        stage('Docker Test') {
            steps {
                sh 'whoami'
                sh 'ls -la /var/run/docker.sock'
                sh 'docker ps -a'
            }
        }}}
   - See Task5_output for the console output     
```
- Create Pipeline, which will build artefact using Dockerfile directly from your github repo (use Dockerfile from previous task).
```
pipeline {
    agent { label 'docker-slave-2' }
  
    stages {
        stage('Docker Test') {
            steps {
                sh 'whoami'
                sh 'ls -la /var/run/docker.sock'
                sh 'docker ps -a'
            }
        }
        stage('Git Clone') {
            steps {
                sh 'git clone https://github.com/AlinaExadel/DevOps-Internship.git'
                sh 'ls -l DevOps-Internship/Task4'
            }
        }
        
        stage('Build Dockerfile') {
            steps {
                sh 'docker build -t alinatkabladze/task4 ./DevOps-Internship/Task4/'
            }
            
        }
      
        }
}
- See Task6-output for console output
```
- Pass  variable PASSWORD=QWERTY! To the docker container. Variable must be encrypted!!!

```
-Goto Manage Jenkins -> Manage Credentials
- Add a global credential in Secret text format
- Update pipeline
pipeline {
    agent { label 'docker-slave-2' }
       environment {
        PASSWORD = credentials('PASSWORD')
    }
    stages {
        stage('Docker Test') {
            steps {
                sh 'whoami'
                sh 'ls -la /var/run/docker.sock'
                sh 'docker ps -a'
            }
        }
        stage('Git Clone') {
            steps {
                sh 'git clone https://github.com/AlinaExadel/DevOps-Internship.git'
                sh 'ls -l DevOps-Internship/Task4'
            }
        }
        
        stage('Build Dockerfile') {
            steps {
                sh 'docker build -t alinatkabladze/task4 ./DevOps-Internship/Task4/'
            }
            
        }
          stage('Run Container') {
            steps {
                sh 'docker run -d -e PASSWORD=${PASSWORD} alinatkabladze/task4'
            }
          }
        }
}
- See Task7-output for console output
```
