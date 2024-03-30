data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket = terraform_remote_state
    key    = "terraform-state-vpc"
    region = var.region
  }
}


data "terraform_remote_state" "iam_state" {
  backend = "s3"

  config = {
    bucket = terraform_remote_state
    key    = "terraform-state-iam"
    region = var.region
  }
}


data "terraform_remote_state" "sg_state" {
  backend = "s3"

  config = {
    bucket = terraform_remote_state
    key    = "terraform-state-sg"
    region = var.region
  }
}


