# Adicionando security group
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssshs"
  description = "Trafego SSH"

  ingress {
    description = "acesso-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cdirs_acesso_remoto
  }

  tags = {
    Name = "SSH"
  }
}
# Criando SG para região do alias apontando no main.tf
# Use o recurso provider para indicar onde será aplicado
# Altere o nomoe do acesso no resource
resource "aws_security_group" "acesso-ssh-us-east-2" {
  provider = "aws.us-east-2"
  name        = "acesso-ssshs"
  description = "Trafego SSH"

  ingress {
    description = "acesso-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # ip da sua máquina. Ele pode ser fixo ou dinâmico.
    cidr_blocks = var.cdirs_acesso_remoto
  }

  tags = {
    Name = "SSH"
  }
}