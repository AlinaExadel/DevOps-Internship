provider "aws" {

  region = "eu-central-1"

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  #                                                                          IGW
  tags = {
    Name = "exadel internet gateway"
  }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  #                                                                ROUTE TABLE PUBLIC SUBNET
  tags = {
    Name = "exadel_RTB"
  }
}

#                 Associate between Public Subnet and Public Route Table
resource "aws_route_table_association" "public" {
  #                                                                  RTB ASSOCIATION PUBLIC
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Exadel"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.0.0/16"
  availability_zone       = "eu-central-1a"
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_instance" "Ubuntu" {
  ami                    = "ami-05f7491af5eef733a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ubuntu_security.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = file("ubuntu.sh")
  key_name               = "Frankfurt"
  tags = {
    Name = "Ubuntu Server"
  }

}
resource "aws_instance" "Centos" {
  ami                    = "ami-0e8286b71b81c3cc1"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.centos_security.id]
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = "Frankfurt"
  tags = {
    Name = "CentOS Server"
  }
}
resource "aws_security_group" "ubuntu_security" {
  name   = "ubuntu_security"
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = ["22", "80", "443"]
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
    Name = "ubuntu_security"
  }
}
resource "aws_security_group" "centos_security" {
  name   = "centos_security"
  vpc_id = aws_vpc.main.id
  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  dynamic "egress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  }
  tags = {
    Name = "centos_security"
  }
}
