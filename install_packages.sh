#!/bin/bash

sudo yum update -y

# install and start jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins

# install and configure docker,docker-compose

sudo yum install docker -y
sudo systemctl enable docker
sudo yum install docker-compose -y
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo gpasswd -a jenkins docker
newgrp docker

# install npm
sudo yum install npm -y
