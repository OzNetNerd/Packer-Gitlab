#!/usr/bin/env bash
wget https://raw.githubusercontent.com/OzNetNerd/Packer-Gitlab/master/Packer/config/docker-setup.sh
chmod +x docker-setup.sh
./docker-setup.sh
rm docker-setup.sh
wget https://raw.githubusercontent.com/OzNetNerd/Packer-Gitlab/master/Packer/config/gitlab-setup.sh
chmod +x gitlab-setup.sh
./gitlab-setup.sh
rm gitlab-setup.sh
chown -R ec2-user:ec2-user /home/ec2-user
rm run.sh