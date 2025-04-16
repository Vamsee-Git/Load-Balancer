resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "subnet" {
  count             = 3
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = element(var.availability_zones, count.index)
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.subnet[*].id
}
