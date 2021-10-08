resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${local.prefix}delete-default-vpcs"
  retention_in_days = var.logs_retention_in_days
  tags              = var.tags
}
