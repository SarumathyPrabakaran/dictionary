
terraform {
  backend "s3" {
    bucket         = "STATE-S3-BUCKET-NAME"
    key            = "terraform-state-sg"
    region         = "us-east-1"
    dynamodb_table = "terraform-state"
  }
}