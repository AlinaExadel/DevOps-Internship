
provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Exadel"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  #
  tags = {
    Name = "public_subnet"
  }
}
resource "aws_instance" "Ubuntu" {
  ami                    = "ami-05f7491af5eef733a"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.ubuntu_security.id]
  user_data              = file("ubuntu.sh")

  tags = {
    Name = "Ubuntu Server"
  }

}
resource "aws_instance" "Centos" {
  ami                    = "ami-0e8286b71b81c3cc1"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.centos_security.id]
  tags = {
    Name = "CentOS Server"
  }
}
resource "aws_security_group" "ubuntu_security" {
  name = "ubuntu_security"

  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_security_group" "centos_security" {
  name = "centos_security"


  dynamic "ingress" {
    for_each = var.ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
    }
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  dynamic "egress" {
    for_each = var.ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
    }
  }

  tags = {
    Name = "allow_tls"
  }
}
