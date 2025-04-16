resource "aws_instance" "web" {
  count               = 3
  ami                 = var.ami
  instance_type       = var.instance_type
  subnet_id           = element(var.subnet_ids, count.index)
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  user_data           = element(var.user_data, count.index)

  tags = {
    Name = "WebServer${count.index}"
  }
}

output "instance_ids" {
  value = aws_instance.web[*].id
}
