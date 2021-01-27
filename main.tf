# Setup na AWS
provider "aws" {
    region = "us-east-1"
}
# Setup em região diferente
# Use um alias pra organiar
provider "aws" {
    alias = "us-east-2"
    region = "us-east-2"
}
# Apontando instância AWS.
# Escolhendo ami
# Escolhendo tipo de instância
# Nome da chave criada localmente e exportada para aws
# Escolha de SecurityGroup
resource "aws_instance" "dev" {
  count = 3
  ami = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name = var.key_pars   
  tags ={
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["sg-0e2a876ca7b45cccd"]
}
# Criando nova VM e associando um bucket
resource "aws_instance" "dev4" {
  ami = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name = var.key_pars
  tags ={
    Name = "dev4"
  }
  vpc_security_group_ids = ["sg-0e2a876ca7b45cccd"]
  depends_on = [aws_s3_bucket.dev4]
}
# Criando nova VM
resource "aws_instance" "dev5" {
  ami = var.amis["us-east-1"]
  instance_type = "t2.micro"
  key_name = var.key_pars
  tags ={
    Name = "dev5"
  }
  vpc_security_group_ids = ["sg-0e2a876ca7b45cccd"]
}
# Criando VM em outra região
# Atenção na AMI e SG, pois são diferentes.
# O depends_on aponta o recurso de DB que vai ser instalado
resource "aws_instance" "dev6" {
  provider = "aws.us-east-2"
  ami = var.amis["us-east-2"]
  instance_type = "t2.micro"
  key_name = var.key_pars
  tags ={
    Name = "dev6"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"]
  depends_on = ["aws_dynamodb_table.dynamodb-homologacao"]
}
#Criando bucket
resource "aws_s3_bucket" "dev4" {
  bucket = "lab-dev4"
  acl    = "private"

  tags = {
    Name        = "lab-dev4"
  }
}
resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider ="aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}