
variable "region" {
  default = "us-east-1"
}
variable "account_id" {
  default = "<Account Id>"
}

variable "frontend_image" {
  description = "The ECR image URI for the frontend container"
  type = string
}

variable "frontend_port" {
  description = "The port to expose for the frontend container"
  default     = 5002
}

variable "backend_image" {
  description = "The ECR image URI for the backend container"
  type = string
}

variable "backend_port" {
  description = "The port to expose for the backend container"
  default     = 5001
}

variable "redis_port" {
  description = "The port to expose for the redis container"
  default = 6379
}
variable "redis_image" {
  description = "The image for the redis container"
  default = "redis" 

}


data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [local.vpc_id]
  }
}

data "aws_subnet" "example" {
  for_each = toset(data.aws_subnets.example.ids)
  id       = each.value
}



locals {
  vpc_id = data.terraform_remote_state.vpc_state.outputs.vpc_id
}



locals {
 vpc_subnets_ids = [for s in data.aws_subnet.example : s.id]
}



locals  {
  security_group = data.terraform_remote_state.sg_state.outputs.security_group_id
}


locals  {
  role = data.terraform_remote_state.iam_state.outputs.iam_role
}




