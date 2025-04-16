variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_ids" {
  description = "List of instance IDs"
  type        = list(string)
}
