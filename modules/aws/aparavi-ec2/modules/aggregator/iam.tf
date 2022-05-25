resource "aws_iam_role" "aggregator_role" {
  name                = "AggregatorRole_${var.deployment_tag}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "aggregator_policy" {
  name = "Aggregator_Policy_${var.deployment_tag}"
  role = aws_iam_role.aggregator_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
            "secretsmanager:GetResourcePolicy",
            "secretsmanager:GetSecretValue",
            "secretsmanager:DescribeSecret",
            "secretsmanager:ListSecretVersionIds",
            "rds:DescribeDBInstances",
            ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "aggregator_profile" {
  name = "Aggregator_Profile_${var.deployment_tag}"
  role = aws_iam_role.aggregator_role.name
}