provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source            = "./modules/vpc"
  cidr_block        = "10.0.0.0/16"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

resource "aws_security_group" "instance" {
  vpc_id = module.vpc.vpc_id

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

module "ec2_instance" {
  source            = "./modules/ec2_instance"
  ami               = "ami-087f352c165340ea1" # Example AMI ID, replace with your own
  instance_type     = "t2.micro"
  subnet_ids        = module.vpc.subnet_ids
  security_group_id = aws_security_group.instance.id
  user_data         = [
    file("${path.module}/user_data/user_data_1.sh"),
    file("${path.module}/user_data/user_data_2.sh"),
    file("${path.module}/user_data/user_data_3.sh")
  ]
}


module "target_group" {
  source       = "./modules/target_group"
  vpc_id       = module.vpc.vpc_id
  instance_ids = module.ec2_instance.instance_ids
}

module "load_balancer" {
  source            = "./modules/load_balancer"
  security_group_id = aws_security_group.instance.id
  subnet_ids        = module.vpc.subnet_ids
  target_group_arns = module.target_group.target_group_arns
}
