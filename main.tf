provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "ec2_setup_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ec2-setup-vpc"
  }
}

resource "aws_subnet" "ec2_setup_subnet" {
  vpc_id            = aws_vpc.ec2_setup_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "ec2-setup-subnet"
  }
}

resource "aws_internet_gateway" "ec2_setup_igw" {
  vpc_id = aws_vpc.ec2_setup_vpc.id

  tags = {
    Name = "ec2-setup-igw"
  }
}

resource "aws_route_table" "ec2_setup_route_table" {
  vpc_id = aws_vpc.ec2_setup_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2_setup_igw.id
  }

  tags = {
    Name = "ec2-setup-route-table"
  }
}

resource "aws_route_table_association" "ec2_setup_route_table_association" {
  subnet_id      = aws_subnet.ec2_setup_subnet.id
  route_table_id = aws_route_table.ec2_setup_route_table.id
}

resource "aws_security_group" "ec2_setup_sg" {
  vpc_id = aws_vpc.ec2_setup_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  ingress {
    from_port   = 5173
    to_port     = 5173
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-setup-security-group"
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ec2-setup-key-pair"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/key-pair/ec2-setup-key-pair.pem"
}

resource "aws_instance" "base_instance" {
  ami           = "ami-012967cc5a8c9f891"  
  instance_type = "t3a.2xlarge"
  key_name      = aws_key_pair.generated_key.key_name
  subnet_id     = aws_subnet.ec2_setup_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_setup_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "ec2-setup-base-instance"
  }
}

output "instance_id" {
  value = aws_instance.base_instance.id
}

output "instance_public_ip" {
  value = aws_instance.base_instance.public_ip
}
