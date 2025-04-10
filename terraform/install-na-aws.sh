#!/bin/bash

apt-get update -y
apt-get install -y nginx docker.io unzip

# services
systemctl start nginx
systemctl enable nginx
systemctl start docker
systemctl enable docker
sudo usermod -aG docker ubuntu

# workdir
mkdir -p /home/ubuntu/easy_terraform_aws
cd /home/ubuntu/easy_terraform_aws

# tarball project
wget -O projeto.tar.gz "https://github.com/everton-tenorio/easy_terraform/releases/latest/download/projeto.tar.gz"
tar -xzf projeto.tar.gz

# Docker
docker build -t easy_terraform_aws .
docker run -d -p 3000:3000 easy_terraform_aws

# nginx
echo '${data.template_file.nginx_conf.rendered}' > /etc/nginx/conf.d/nuxt_container.conf
rm -rf /etc/nginx/sites-enabled/default # Remover configuração padrão do nginx
systemctl restart nginx
