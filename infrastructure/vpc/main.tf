

provider "aws" {
  region = "us-east-1"
}

variable "region" {
  default = "us-east-1"
}

resource "aws_vpc" "main" {

  cidr_block       = var.cidr_vpc
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_subnet_public
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "dict-IGW"
  }
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_default_vpc_dhcp_options" "default" {

}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_default_vpc_dhcp_options.default.id
}


output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC Id"
}

output "subnet_id" {
  value       = aws_subnet.main.id
  description = "Subnet ID"
}
