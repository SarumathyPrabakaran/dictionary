
provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-east-1"
}
resource "aws_ecr_repository" "frontend" {
  name = "dictionary_frontend"
  force_delete = true
}

resource "aws_ecr_repository" "backend" {
  name = "dictionary_backend"
  force_delete = true
}
