#Create a VPC
resource "aws_vpc" "all_apps_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = format("%s-VPC",var.instance_name)
  }
}

#Create an Internet Gateway
resource "aws_internet_gateway" "apps-igw" {
  vpc_id = aws_vpc.all_apps_vpc.id
  tags = {
    Name = format("%s-igw",var.instance_name)
  }
}

# Create a Route Table for the VPC
resource "aws_route_table" "route_public" {
  vpc_id = aws_vpc.all_apps_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.apps-igw.id
  }
  tags = {
   Name = format("%s-public-route",var.instance_name)
  }
}

# Create a Subnet within the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.all_apps_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = format("%s-public-subnet",var.instance_name)
  }
}

resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_public.id
  
}

resource "aws_security_group" "my_app_sg" {
  name_prefix = format("%s-sg",var.instance_name)
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id = aws_vpc.all_apps_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
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
  Name = format("%s-sec-gw",var.instance_name)
  }
}

resource "aws_key_pair" "my_app_key" {
  key_name   = "fastapiapp-key"
  public_key = var.SSH_PUBLIC_KEY
}

resource "aws_instance" "myEc2-instance" {
  ami = var.ami  
  instance_type = var.instance_type
  subnet_id = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.my_app_sg.id]
  key_name          = aws_key_pair.my_app_key.key_name
  tags = {
    Name = format("%s-ec2-instance",var.instance_name)
  }
}

