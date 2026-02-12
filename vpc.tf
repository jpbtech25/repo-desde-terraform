data "aws_availability_zones" "available" {
  state         = "available"
  exclude_names = ["us-east-1e"] # Esto evita el error de la t3.micro
}

resource "aws_vpc" "vpc_virginia" {
cidr_block = var.virginia_cdir
tags = {
"Name" = "vpc_virginia"
}
}


resource "aws_subnet" "public_subnet" {
 vpc_id = aws_vpc.vpc_virginia.id
 cidr_block = var.subnets[0]
 map_public_ip_on_launch = true
availability_zone       = data.aws_availability_zones.available.names[0]
tags = {
"Name" = "public_subnet"
} 
}

resource "aws_subnet" "private_subnet" {
vpc_id= aws_vpc.vpc_virginia.id
cidr_block = var.subnets[1]
  availability_zone = data.aws_availability_zones.available.names[1]
tags = {
"Name" = "private_subnet"
}
depends_on = [
aws_subnet.public_subnet
]

}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

tags = {
  Name= "igw vpc virginia"
}

}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public crt"
  }
} 

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

resource "aws_security_group" "sg_public_instance" {
  name        = "Public Instance SG"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

}

resource "aws_vpc_security_group_ingress_rule" "allow_all_inbound" {
  security_group_id = aws_security_group.sg_public_instance.id
  description = "SSH over Internet"
  cidr_ipv4         = var.sg_ingress_cdir
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_egress" {
  security_group_id = aws_security_group.sg_public_instance.id
 # cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

tags = {
  Name = "Public Instance SG"
}
}

module "mybucket" {
  source = "./Modulos/s3"
  bucket_name = "nombreunicojpb1234567"
}

output "s3_arn" {
value = module.mybucket.s3_bucket_arn

}

  #  module "terraform_state_backend" {
  #    source = "cloudposse/tfstate-backend/aws"
  #    # Cloud Posse recommends pinning every module to a specific version
  #    version     = "1.8.0"
  #    namespace  = "examplejpb2026"
  #    stage      = "prod"
  #    name       = "terraform"
  #    attributes = ["state"]

  #    terraform_backend_config_file_path = "."
  #    terraform_backend_config_file_name = "backend.tf"
  #    force_destroy                      = false
  #  }
  
