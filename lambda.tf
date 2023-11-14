data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_generatePassword.py"
  output_path = "lambda_generatePassword.zip"
}

resource "aws_lambda_function" "generatePassword" {
  filename      = "lambda_generatePassword.zip"
  function_name = "generatePassword"
  role          = aws_iam_role.iam_for_lambda.arn
  runtime       = "python3.9"
  handler       = "lambda_generatePassword.lambda_handler"
}