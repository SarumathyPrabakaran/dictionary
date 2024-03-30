
terraform {
  backend "s3" {
    bucket         = "STATE-S3-BUCKET-NAME"
    key            = "terraform-state-vpc"
    region         = "us-east-1"
    dynamodb_table = "terraform-state"
  }
}