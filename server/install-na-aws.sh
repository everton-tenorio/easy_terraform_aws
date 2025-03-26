#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y

# Nginx
sudo apt-get install nginx -y

# Remover o arquivo de configuração padrão
sudo rm -f /etc/nginx/sites-enabled/default

# Docker
sudo apt-get install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

# git e wget
sudo apt-get install git wget -y

# Clona o repositório
git clone https://github.com/everton-tenorio/easy_terraform_aws.git /home/ubuntu/easy_terraform_aws

# Baixa o arquivo de configuração do Nginx do repositório
wget -O /etc/nginx/conf.d/easytf.conf https://raw.githubusercontent.com/everton-tenorio/easy_terraform_aws/main/server/easytf.conf

# Docker: build da imagem + executar a imagem
cd /home/ubuntu/easy_terraform_aws
sudo docker build -t easy_terraform_aws .
sudo docker run -d -p 3000:3000 easy_terraform_aws

# Restart Nginx
sudo systemctl restart nginx