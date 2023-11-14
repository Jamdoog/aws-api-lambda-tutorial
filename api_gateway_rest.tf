resource "aws_api_gateway_rest_api" "proxy" {
  name        = "generatePassword"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.proxy.id
  parent_id   = aws_api_gateway_rest_api.proxy.root_resource_id
  path_part   = "generate"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.proxy.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = aws_api_gateway_rest_api.proxy.id
  resource_id = aws_api_gateway_method.proxy.resource_id
  http_method = aws_api_gateway_method.proxy.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.generatePassword.invoke_arn
}

resource "aws_api_gateway_deployment" "generatePassword" {
  depends_on = [
    aws_api_gateway_integration.lambda,
  ]

  rest_api_id = aws_api_gateway_rest_api.proxy.id
  stage_name  = "prod"
}

resource "aws_lambda_permission" "proxy" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.generatePassword.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.proxy.execution_arn}/*/*/*"
}

output "base_url" {
  value = aws_api_gateway_deployment.generatePassword.invoke_url
}