module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 3.0"

  name = "${var.namespace}-rds-db"
  identifier = "${var.namespace}-rds-db"

  engine         = var.engine
  engine_version = var.engine_version

  subnet_ids = var.subnet_ids


  vpc_security_group_ids = var.vpc_security_group_ids
  instance_class          = var.instance_type

  create_monitoring_role = var.create_monitoring_role
  storage_encrypted      = var.storage_encrypted

  publicly_accessible = var.publicly_accessible

  username            = var.username
  password            = var.password
  port                = var.port
  deletion_protection = var.deletion_protection

  enabled_cloudwatch_logs_exports = var.cloudwatch_export_logs

  tags = {
    Owner = var.owner
  }
}
