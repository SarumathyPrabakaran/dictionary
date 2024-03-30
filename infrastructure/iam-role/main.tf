provider "aws" {
  region = "us-east-1"
}


variable "region" {
  default = "us-east-1"
}



resource "aws_iam_role" "ecs_role" {
  name = "ecr-ecs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    , "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicFullAccess",
  "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"]
}


output "iam_role" {
  value = aws_iam_role.ecs_role.arn
}
