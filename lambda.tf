resource "aws_iam_role" "default" {
  name = "${local.prefix}lambda"
  tags = var.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": "LambdaDeleteDefaultVCPs"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "default" {
  name   = "${local.prefix}lambda"
  role   = aws_iam_role.default.id
  policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }

  statement {
    actions = [
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNetworkAcl",
      "ec2:DeleteRouteTable",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:DeleteVpc",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRegions",
      "ec2:DescribeRegions",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DetachInternetGateway",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_lambda_function" "default" {
  filename         = data.archive_file.default.output_path
  source_code_hash = filebase64sha256(data.archive_file.default.output_path)
  function_name    = "${local.prefix}delete-default-vpcs"
  handler          = "app.handler"
  runtime          = "python3.9"
  timeout          = "900"
  role             = aws_iam_role.default.arn
  tags = var.tags

  depends_on = [
    aws_cloudwatch_log_group.default,
  ]
}

data "archive_file" "default" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/"
  output_path = "/tmp/lambda_delete_default_vpcs.zip"
}
