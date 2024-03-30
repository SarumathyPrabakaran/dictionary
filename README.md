# Dockerized Dictionary App

## Overview
This project is aimed at deploying a Dockerized Dictionary App using Terraform for infrastructure provisioning. The application consists of backend, frontend, and Redis components, which will be containerized and deployed to AWS ECS (Elastic Container Service) with the help of AWS ECR (Elastic Container Registry) for storing Docker images. CloudMap is utilized for service discovery within the ECS cluster.

## Terraform Infrastructure Provisioning
The following components will be provisioned using Terraform:

1. **VPC**: Virtual Private Cloud for hosting the infrastructure.
2. **Security Group**: For controlling inbound and outbound traffic.
3. **IAM Role**: Identity and Access Management role for ECS tasks.
4. **ECR Repositories**: Backend, Frontend, and Redis Docker images will be pushed to separate ECR repositories.
5. **ECS Task Definitions**: Task definitions for backend, frontend, and Redis containers.
6. **ECS Cluster**: An ECS cluster to host the Docker containers.
7. **ECS Services**: Three different services for each task definition, each running a single container.
8. **Cloud Map Configuration**: Service discovery and connection establishment within the ECS cluster using Cloud Map.
9. **Private Hosted Zone and Namespace**: Creation of a private hosted zone and namespace for service discovery.

## Deployment Steps
Follow these steps to deploy the Dockerized Dictionary App:

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Update Configuration**: Modify the variables in the Terraform configuration files (`variables.tf`, `main.tf`) as per your requirements, such as AWS credentials, VPC settings, etc.
3. **Execute Deployment Script**: Run the deployment script provided below.

Scripts:
Make sure to give executable permissions to the scripts:
    ```chmod +x file-name.sh```

1. For backend initialization and configuration
    ```./terraform-init.sh```


2. For terraform plan:
    ```./infra-plan-check.sh```

3. For terraform apply. Be careful as it will apply directly without prompting because of auto-approve(Make sure to check plan before applying)

    ```./build-push-deploy.sh```

4. For terraform destroy. Be careful as it will destroy directly without prompting because of auto-approve.

    ```./stop-rmi-destroy.sh```