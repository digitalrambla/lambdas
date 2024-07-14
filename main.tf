provider "aws" {
  region = "us-west-2"
}

resource "aws_ecr_repository" "my_lambda_repo" {
  name = "my-lambda-repo"
}

data "aws_ecr_repository" "my_lambda_repo" {
  name = aws_ecr_repository.my_lambda_repo.name
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_exec_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "docker_lambda" {
  function_name = "docker-lambda-function"
  role          = aws_iam_role.lambda_exec.arn
  package_type  = "Image"

  image_uri = "${data.aws_account_id.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${aws_ecr_repository.my_lambda_repo.name}:latest"
}

output "lambda_function_name" {
  value = aws_lambda_function.docker_lambda.function_name
}
