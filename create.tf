#Provider
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region  = "${var.aws_region}"
}
#EC2
resource "aws_instance" "terraform_ec2" {
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
#Pem_key
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.terraform_sg.id}"]
  subnet_id              = "${aws_subnet.subnet1.id}"
  associate_public_ip_address = true
  user_data = "${file("install_http.sh")}"
  tags = {
    Name = "${var.aws_instance_name}"
  }
}

