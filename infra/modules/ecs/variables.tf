variable "namespace" {
  type = string
}

variable "region" {
  type = string
}

variable "aws_ecr_repository_url" {
  description = "Amazon ECR repository URL"
}

variable "subnets" {
  description = "Subnet where ECS placed"
  type        = list(any)
}

variable "security_groups" {
  description = "One or more VPC security groups associated with ECS cluster"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN"
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "desired_count" {
  type = number
}

variable "aws_cloudwatch_log_group_name" {
  description = "AWS CloudWatch Log Group name"
}

variable "aws_parameter_store" {
  default = "arn:aws:ssm:ap-southeast-1:301618631622:parameter/codewar-web/staging"
}

variable "owner" {
  type = string
}
