

resource "aws_ecs_cluster" "main" {
  name = "dict-cluster"
}


resource "aws_ecs_task_definition" "frontend_definition" {
  family                   = "frontend_definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = local.role
  cpu                      = 1024
  memory                   = 2048

  container_definitions = templatefile("template-files/frontend_def.tpl", 
    {
      "frontend_port" = var.frontend_port, 
      "frontend_image" = var.frontend_image
      })
  

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}


resource "aws_ecs_task_definition" "backend_definition" {
  family                   = "backend_definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = local.role
  cpu                      = 1024
  memory                   = 2048


  container_definitions = templatefile("template-files/backend_def.tpl", 
  { "backend_port" = var.backend_port, "backend_image" = var.backend_image, "redis_port" = var.redis_port, "redis_image" = var.redis_image, "redis_host" = local.redis_host })
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}


resource "aws_ecs_task_definition" "redis_definition" {
  family                   = "redis_definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = local.role
  cpu                      = 1024
  memory                   = 2048


  container_definitions = templatefile("template-files/redis_def.tpl", 
  { "redis_port" = var.redis_port })
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}



resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend_definition.arn
  
  network_configuration {
    
    subnets = local.vpc_subnets_ids
    assign_public_ip = "true"
    security_groups = [local.security_group]
  }
  launch_type = "FARGATE"
  desired_count   = 1
}


resource "aws_ecs_service" "backend" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend_definition.arn
  network_configuration {
    subnets = local.vpc_subnets_ids
    assign_public_ip = "true"
    security_groups = [local.security_group]
  }
  service_registries {
    registry_arn = aws_service_discovery_service.dictionary.arn
  }
  launch_type = "FARGATE"
  desired_count   = 1
}


resource "aws_ecs_service" "redis" {
  name            = "redis-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.redis_definition.arn
  
  network_configuration {
    subnets          = local.vpc_subnets_ids
    assign_public_ip = "true"
    security_groups  = [local.security_group]
  }
  service_registries {
    registry_arn = aws_service_discovery_service.redis.arn
  }
  launch_type     = "FARGATE"
  desired_count   = 1
}



resource "aws_service_discovery_private_dns_namespace" "dictionary" {
  name        = "saru"
  description = "DNS namespace name"
  vpc         = local.vpc_id
}


resource "aws_service_discovery_service" "dictionary" {
  name = "saru-server"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.dictionary.id

    dns_records {
      ttl  = 300
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}


resource "aws_service_discovery_service" "redis" {
  name = "redis-server"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.dictionary.id

    dns_records {
      ttl  = 500
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

locals {
  redis_host = "redis-server.saru"
}

output "subnet_ids" {
  value = local.vpc_subnets_ids
}
