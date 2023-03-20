#this file consists of code for instances and sg
provider "aws" {
region = "ap-northeast-1"
access_key = "AKIAXYBMUS6Z3OJEBWPA"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-030cf0a1edb8636ab"
  instance_type   = "t2.micro"
  key_name        = "shiva3"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-1"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by raham sir server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-030cf0a1edb8636ab"
  instance_type   = "t2.micro"
  key_name        = "shiva3"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-1"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by raham sir server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "server-2"
  }
}

resource "aws_security_group" "three" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "four" {
  bucket = "harish1808"
}

resource "aws_iam_user" "five" {
name = "harish22" 
}

resource "aws_ebs_volume" "six" {
 availability_zone = "ap-northeast-1"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
