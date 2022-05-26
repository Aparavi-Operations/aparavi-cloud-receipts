resource "aws_iam_role" "monitoring_role" {
  name = "MonitoringRole_${var.deployment_tag}"
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
  name = "Monitoring_Policy_${var.deployment_tag}"
  role = aws_iam_role.monitoring_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeAvailabilityZones",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "monitoring_profile" {
  name = "Monitoring_Profile_${var.deployment_tag}"
  role = aws_iam_role.monitoring_role.name
}