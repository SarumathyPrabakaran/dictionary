#!/bin/bash

STATE_BUCKET_NAME="STATE_S3_BUCKET_NAME"
AWS_REGION="us-east-1"

export TF_VAR_state_bucket=$STATE_BUCKET_NAME
export TF_VAR_region=$AWS_REGION

cd ./infrastructure/vpc
terraform init 

cd ../security-group
terraform init 

cd ../iam-role
terraform init 

cd ../ecr
terraform init 

cd ../ecs
terraform init 

