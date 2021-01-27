# Existem vários tipos de variáveis. Busque
# Definindo variáveis com AMI´s
# variavel tipo map
variable "amis" {
  type        = map
  default     = {
      "us-east-1" = "ami-0885b1f6bd170450c"
      "us-east-2" = "ami-0a91cd140a1fc148a"
  }
  description = "Variáveis com ami´s"
}
# variável tipo string
variable "cdirs_acesso_remoto" {
    type = list
    default = ["201.80.1.28/32", "201.80.1.29/32"]
    description = "Variáveis de bloco de ips"
}
# variavel tipo default
variable "key_pars" {
    default = "terraform"
    description = "Variável default"
}
