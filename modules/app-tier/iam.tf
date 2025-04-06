resource "aws_iam_role" "app_role" {
  name = "app-tier-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "app_policy" {
  name        = "app-tier-policy"
  description = "Allow app tier to access S3 and DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject"],
        Resource = "arn:aws:s3:::my-app-data/*"
      },
      {
        Effect   = "Allow",
        Action   = ["dynamodb:Query", "dynamodb:GetItem"],
        Resource = "arn:aws:dynamodb:us-east-1:123456789012:table/my-app-table"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_app_policy" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.app_policy.arn
}