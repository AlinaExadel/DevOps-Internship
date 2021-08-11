
provider "aws" {

  region = "eu-central-1"
}

resource "aws_instance" "Ubuntu" {
  ami                    = "ami-05f7491af5eef733a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ubuntu_security.id]
  user_data              = file("ubuntu.sh")

  tags = {
    Name = "Ubuntu Server"
  }

}
resource "aws_instance" "Centos" {
  ami                    = "ami-0e8286b71b81c3cc1"
  instance_type          = "t2.micro"
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
      cidr_blocks = ["172.31.0.0/20"]
    }
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.31.0.0/20"]
  }
  dynamic "egress" {
    for_each = var.ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["172.31.0.0/20"]
    }
  }

  tags = {
    Name = "allow_tls"
  }
}
