[
  {
    "name": "${namespace}",
    "image": "${aws_ecr_repository}:${tag}",
    "memory": 256,
    "essential": true,
    "cpu": 1,
    "portMappings": [
      {
        "containerPort": ${app_port},
        "hostPort": ${app_port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${namespace}-service-web",
        "awslogs-group": "${aws_cloudwatch_log_group_name}"
      }
    },
    "environment": [
      {
        "name": "HOST",
        "value": "codewar-web-staging-alb-11830061.ap-southeast-1.elb.amazonaws.com"
      },
      {
        "name": "PORT",
        "value": "${app_port}"
      }
    ],
    "secrets": [
      {
        "name": "DATABASE_URL",
        "valueFrom": "${aws_parameter_store}/DATABASE_URL"
      },
      {
        "name": "SECRET_KEY_BASE",
        "valueFrom": "${aws_parameter_store}/SECRET_KEY_BASE"
      }
    ]
  }
]
