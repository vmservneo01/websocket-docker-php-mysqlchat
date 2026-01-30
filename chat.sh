#!/bin/bash
#--------------------------------------------------------------------
# Script to Install Php Chat Server on Linux Ubuntu
# Tested on Ubuntu 22.04, 24.04
# Developed by vagrantservernode-01 in 2025
#--------------------------------------------------------------------
SERVERIP=""

###install packages
sudo apt update && apt upgrade
sudo apt install chrony -y           #time
sudo apt install docker-compose -y   #build image
sudo apt-get install -y docker-ce docker-ce-cli docker-compose containerd.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker vmadmin01
sudo apt install ufw -y              #firewall
sudo apt install git -y              #git

## install and synchronize time
#sudo timedatectl set-timezone Europe/Moscow
#sudo systemctl enable chrony

###git clone
git clone https://github.com/vmservneo01/websocket-docker-php-mysqlchat.git
cd  websocket-docker-php-mysqlchat


#host name
sudo echo "$SERVERIP websockchat.ru" | sudo tee -a /etc/hosts


### use docker-compose for build image
#sudo chmod +x /usr/local/bin/docker-compose 
#sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose #access from anywhere
#sudo rm -rf ./.data/db/*
sudo docker-compose build
sudo docker-compose up -d
sudo docker-compose logs nginx >> ./logs/docker-compose/logs_nginx
sudo docker-compose logs apache >> ./logs/docker-compose/logs_apache
sudo docker-compose logs apache >> ./logs/docker-compose/logs_mysql

### setup firewall
#sudo apt install ufw -y
#sudo ufw allow ssh 
#sudo ufw allow in 80/tcp
#sudo ufw enable


