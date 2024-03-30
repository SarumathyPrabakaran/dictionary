[{
  "name": "frontendimage",
  "image": "${frontend_image}",
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
      "containerPort": ${frontend_port},
      "hostPort": ${frontend_port},
      "protocol": "tcp",
      "appProtocol": "http"
    }
  ],
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-create-group": "true",
      "awslogs-group": "/ecs/dictfront",
      "awslogs-region": var.region,
      "awslogs-stream-prefix": "ecs"
    }
  }
}
]