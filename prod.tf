provider "aws"  {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tf-testing2022-09-04"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "prod_web" {
  name 	      = "prod_web"
  description = "Allow standard http and https ports inbound and eveything outbound"
	
  ingress {
    from_port    = 80
    to_port      = 80
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  } 
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags =  {
    "terraform" = "true" 
  } 
}

resource "aws_instance" "prod_web" {
  ami 		= "ami-03c8adc67e56c7f1d"
  instance_type = "t2.nano"
  
  vpc_security_group_ids = [
     aws_security_group.prod_web.id
  ]

  tags = { 
    "Terraform" : "true"
 }
}

resource "aws_eip" "prod_web" {
  instance = aws_instance.prod_web.id 
  tags = {
    "Terraform" : "true"
  }
}
