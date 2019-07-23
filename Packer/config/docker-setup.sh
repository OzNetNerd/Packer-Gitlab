#!/bin/bash -e
sudo yum update -y
sudo yum upgrade -y
sudo yum install git -y
sudo amazon-linux-extras install -y docker
sudo systemctl enable docker
sudo systemctl restart docker
sudo usermod -a -G docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose