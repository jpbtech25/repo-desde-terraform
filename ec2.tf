resource "aws_instance" "public_instance" {
  count         = 5
  ami           = var.ec2_specs.ami
  instance_type = var.ec2_specs.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "InstanciaFinalOk"
  }
  key_name               = data.aws_key_pair.key_name.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data_base64       = base64encode(file("scripts/userdata.sh"))
}


