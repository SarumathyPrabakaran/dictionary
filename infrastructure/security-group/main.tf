
variable "region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.region
}



data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket = var.state_bucket
    key    = "terraform-state-vpc"
    region = var.region
  }
}


resource "aws_security_group" "dict" {
  name        = "dictionary-security-group"
  description = "To allow ports"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id
   
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_5001" {
  security_group_id = aws_security_group.dict.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5001
  ip_protocol       = "tcp"
  to_port           = 5001
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_5002" {
  security_group_id = aws_security_group.dict.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5002
  ip_protocol       = "tcp"
  to_port           = 5002
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_redis" {
  security_group_id = aws_security_group.dict.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 6379
  ip_protocol       = "tcp"
  to_port           = 6379
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_http" {
  security_group_id = aws_security_group.dict.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

output "security_group_id" {
  value = aws_security_group.dict.id
}