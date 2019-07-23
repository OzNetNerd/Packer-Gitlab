#!/bin/bash -e
sudo yum update -y
sudo yum upgrade -y
sudo yum install git -y
sudo docker pull gitlab/gitlab-ce:latest
sudo docker pull gitlab/gitlab-runner:alpine
sudo docker pull docker:stable
sudo docker pull registry:2
