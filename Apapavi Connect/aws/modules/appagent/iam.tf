resource "aws_iam_role" "appagent_role" {
  name                = "appagentRole_${var.deployment_tag}"
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

resource "aws_iam_role_policy" "appagent_policy" {
  name = "appagent_Policy_${var.deployment_tag}"
  role = aws_iam_role.appagent_role.id

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

resource "aws_iam_instance_profile" "appagent_profile" {
  name = "appagent_Profile_${var.deployment_tag}"
  role = aws_iam_role.appagent_role.name
}