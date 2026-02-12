variable "virginia_cdir" {
  description = "CIDR Virginia"
  type        = string
}

variable "subnets" {
  type    = list(string)
  default = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "sg_ingress_cdir" {
  type    = string
  default = "0.0.0.0/0"
}

variable "tags" {
  type = map(string)
}

variable "ec2_specs" {
  type = map(string)
}

variable "github_token" {
  description = "Token de acceso personal para GitHub"
  type        = string
  sensitive   = true  # Esto evita que el token se imprima en la pantalla durante el apply
}

variable "access_key" { 

}

variable "secret_key" {
  
}