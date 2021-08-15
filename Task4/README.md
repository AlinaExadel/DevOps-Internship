* Install Docker with bash script
  * #!/bin/bash
  * sudo apt -y update
  * sudo apt install apt-transport-https
  * curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  * sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable" 
  * sudo apt-get update -y
  * sudo apt-get install docker-ce -y
* Find, download and run any docker container "hello world" 
  * docker run hello-world
* Create your Dockerfile for building a docker image. Your docker image should run any web application (nginx, apache, httpd). Web application should be located inside the docker image. 
   * Dockerfile - https://github.com/AlinaExadel/DevOps-Internship/blob/master/Task4/Dockerfile
   * Create docker image from Dockerfile - docker build -t task4
   * My IP - http://3.18.108.169/
 * Push your docker image to docker hub
   * docker tag existing-image hub-user/repo-name:tag
   * docker push hub-user/repo-name:tag
   * My repo path - https://hub.docker.com/repository/docker/alinatkabladze/task4
 * Create Docker-Compose 
   * docker-compose.yml link - https://github.com/AlinaExadel/DevOps-Internship/blob/master/Task4/docker-compose.yml
   * For running 5 nodes - docker-compose up -d --scale web=5 
