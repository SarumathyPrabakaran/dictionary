[{
    "name": "backendimage",
    "image": "${backend_image}",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "name": "80",
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp",
        "appProtocol": "http"
      },
      {
        "name": "5001",
        "containerPort": ${backend_port},
        "hostPort": ${backend_port},
        "protocol": "tcp",
        "appProtocol": "http"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "/ecs/dictbackend",
        "awslogs-region": var.region,
        "awslogs-stream-prefix": "ecs"
      }
    },
    "environment": [
      {
        "name": "CACHE_TYPE",
        "value": "redis"
      },
      {
        "name": "CACHE_REDIS_HOST",
        "value": "${redis_host}"
      },
      {
        "name": "CACHE_REDIS_PORT",
        "value": "6379"
      },
      {
        "name": "CACHE_REDIS_DB",
        "value":"0"
      },
      {
        "name": "CACHE_REDIS_URL",
        "value": "redis://${redis_host}:6379/0"
      },
      {
        "name": "CACHE_DEFAULT_TIMEOUT",
        "value": "500"
      }
    ]
  }
]