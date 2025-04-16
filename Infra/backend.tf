terraform {
  backend "s3" {
    bucket         = "terraform-state-backend-vamsee"
    key            = "terraform/loadbalancer"
    region         = "us-west-1"
    encrypt        = true
  }
}
