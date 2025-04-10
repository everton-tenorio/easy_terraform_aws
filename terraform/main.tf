provider "aws" {
  region = "us-east-1" # Região
}

variable "my_ip" {
  description = "Meu endereço IP"
  type        = string
}

# Usar filtros para buscar a AMI do Ubuntu 22.04 LTS
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Chave SSH
resource "aws_key_pair" "my_key" {
  key_name   = "ec2-key"
  public_key = file("~/.ssh/aws/my_key.pub")
}

# Provisionando:
# VPC e sub-rede pública
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group
resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"] # IP dinâmico via variável
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Template do Nginx (Fazendo proxy reverso para porta 3000)
data "template_file" "nginx_conf" {
  template = <<-EOF
    server {
        listen 80;
        server_name _;

        location / {
            proxy_pass http://localhost:3000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
  EOF
}

# Instância EC2
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type         = "t2.micro" # Free Tier
  key_name              = aws_key_pair.my_key.key_name
  subnet_id             = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Atualizar sistema e instalar dependências
              apt-get update -y
              apt-get install -y nginx docker.io unzip

              # Iniciar e habilitar serviços
              systemctl start nginx
              systemctl enable nginx
              systemctl start docker
              systemctl enable docker
              sudo usermod -aG docker ubuntu


              # Criar diretório de trabalho
              mkdir -p /home/ubuntu/easy_terraform_aws
              cd /home/ubuntu/easy_terraform_aws

              # Baixar o tarball do Projeto
              wget -O projeto.tar.gz "https://github.com/everton-tenorio/easy_terraform_aws/releases/download/build-13/projeto.tar.gz"
              tar -xzf projeto.tar.gz

              # Construir e rodar o container
              docker build -t easy_terraform_aws .
              docker run -d -p 3000:3000 easy_terraform_aws

              # Configurar o Nginx com o novo arquivo
              echo '${data.template_file.nginx_conf.rendered}' > /etc/nginx/conf.d/nuxt_container.conf
              rm -rf /etc/nginx/sites-enabled/default # Remover configuração padrão do nginx
              systemctl restart nginx
              EOF

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "easy-instance-aws",
    Author = "Everton Tenorio",
    Linkedin = "https://linkedin.com/in/everton-st"
  }
}
