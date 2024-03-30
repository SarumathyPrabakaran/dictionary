[
    {
      "name"      : "redis",
      "image"     : "redis:latest",
      "cpu"       : 512,
      "memory"    : 1024,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : ${redis_port},
          "hostPort"      : ${redis_port},
          "protocol"      : "tcp"
        }
      ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "/ecs/dictredis",
        "awslogs-region": var.region,
        "awslogs-stream-prefix": "ecs"
      }
    }
    }
  
]