#aws_access_key
variable "aws_access_key" {
  default = "your_access__key"
}
#aws_secret_key
variable "aws_secret_key" {
  default = "your_secret_key"
}

#Region
variable "aws_region" {
  default = "us-east-1"
}

#ami_id
variable "ami" {
  default = "ami-000db10762d0c4c05"
}
#EC2_instance_name
variable "aws_instance_name" {
  default = "terraform_ec2"
}
#pem_key
variable "key_name" {
  default = "your_pem_key"
}

