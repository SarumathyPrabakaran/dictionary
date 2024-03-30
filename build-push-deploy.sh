#!/bin/bash


AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="<AWS Account ID>"
FRONT_REPOSITORY="dictionary_frontend"
BACK_REPOSITORY="dictionary_backend"


terraform -chdir="./infrastructure/vpc" apply -auto-approve -var="region="$AWS_REGION"

terraform -chdir="./infrastructure/security-group" apply -auto-approve -var="region="$AWS_REGION"

terraform -chdir="./infrastructure/iam-role" apply -auto-approve -var="region="$AWS_REGION"

terraform -chdir="./infrastructure/ecr" apply -auto-approve -var="region="$AWS_REGION"

aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

docker build -t $FRONT_REPOSITORY ./frontend
docker tag $FRONT_REPOSITORY:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONT_REPOSITORY:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONT_REPOSITORY:latest

docker build -t $BACK_REPOSITORY ./backend
docker tag $BACK_REPOSITORY:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACK_REPOSITORY:latest
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACK_REPOSITORY:latest


terraform -chdir="./infrastructure/ecs" apply -auto-approve 
    -var="backend_image=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACK_REPOSITORY:latest" 
    -var="frontend_image=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONT_REPOSITORY:latest"  
    -var="region="$AWS_REGION"


