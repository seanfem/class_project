# Create a VPC
resource "aws_vpc" "devops" {
  cidr_block = "10.0.0.0/16"
}
# Create a subnet
resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.devops.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = "${aws_vpc.devops.id}"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet2"
  }
}
# Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.devops.id}"

  tags = {
    Name = "devopsgt"
  }
}
# Create route
resource "aws_route_table" "route1" {
  vpc_id = "${aws_vpc.devops.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "route1"
  }
}
# Route association
resource "aws_route_table_association" "route1" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.route1.id}"
}
#Network interface
data "aws_network_interface" "eth0" {
  id = "eni-0c50acf8c138f122b"
}
#EC2
#resource "aws_instance" "terraform_instance" {
# ami           = "ami-000db10762d0c4c05"
#  instance_type = "t2.micro"
#  key_name      = "your_pem_key"
#  tags = {
#    Name = "terraform_ec2"
#  }
#}
# Security Group
resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg"
  description = "Allow http inbound traffic"
  vpc_id      = "${aws_vpc.devops.id}"

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
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform_sg"
  }
}
