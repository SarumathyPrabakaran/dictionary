
terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 5.0"
   }
 }
}

provider "aws" {
 region = var.region
}

variable "region" {
  default = "us-east-1"
}

variable "state_bucket" {
  description = "The bucket to store the state"
}

resource "aws_s3_bucket" "terraform-state" {

  bucket = var.state_bucket
  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = aws_kms_key.terraform-bucket-key.arn
    }
  }
}

resource "aws_kms_key" "terraform-bucket-key" {
 description             = "This key is used to encrypt bucket objects"
 deletion_window_in_days = 10
 enable_key_rotation     = true
}

resource "aws_kms_alias" "key-alias" {
 name          = "alias/terraform-bucket-key"
 target_key_id = aws_kms_key.terraform-bucket-key.key_id
}



resource "aws_dynamodb_table" "terraform-state" {
 name           = "terraform-state"
 read_capacity  = 20
 write_capacity = 20
 hash_key       = "LockID"

 attribute {
   name = "LockID"
   type = "S"
 }
}


output "state_bucket_name" {
  value = aws_s3_bucket.terraform-state.bucket
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform-state.name 
}