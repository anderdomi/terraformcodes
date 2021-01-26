provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "dev" {
  count = 3
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  key_name = "terraform"
  tags ={
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["sg-0e2a876ca7b45cccd"]
}

resource "aws_instance" "dev4" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  key_name = "terraform"
  tags ={
    Name = "dev4"
  }
  vpc_security_group_ids = ["sg-0e2a876ca7b45cccd"]
  depends_on = [aws_s3_bucket.dev4]
}

resource "aws_instance" "dev5" {
  ami = "ami-0885b1f6bd170450c"
  instance_type = "t2.micro"
  key_name = "terraform"
  tags ={
    Name = "dev5"
  }
  vpc_security_group_ids = ["sg-0e2a876ca7b45cccd"]
}

resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssshs"
  description = "Trafego SSH"

  ingress {
    description = "acesso-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["201.80.1.28/32"]
  }

  tags = {
    Name = "SSH"
  }
}
resource "aws_s3_bucket" "dev4" {
  bucket = "lab-dev4"
  acl    = "private"

  tags = {
    Name        = "lab-dev4"
  }
}
