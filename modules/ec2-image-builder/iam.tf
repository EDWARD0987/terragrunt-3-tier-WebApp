resource "aws_iam_role" "image_builder_role" {
  name = "EC2ImageBuilderRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "image_builder_profile" {
  name = "EC2ImageBuilderInstanceProfile"
  role = aws_iam_role.image_builder_role.name
}