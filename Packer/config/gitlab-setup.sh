#!/bin/bash -e
sudo yum update -y
sudo yum upgrade -y
sudo yum install git -y
sudo docker pull gitlab/gitlab-ce:latest
sudo docker pull gitlab/gitlab-runner:alpine
sudo docker pull docker:stable
sudo docker pull registry:2
mkdir -p /home/ec2-user/gitlab-config
cd  /home/ec2-user/gitlab-config
wget https://raw.githubusercontent.com/OzNetNerd/Packer-Gitlab/master/Packer/config/Makefile
wget https://raw.githubusercontent.com/OzNetNerd/Packer-Gitlab/master/Packer/config/docker-compose.yml
sudo chown -R ec2-user:ec2-user /home/ec2-user