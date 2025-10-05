//API Gateway HTTP API
resource "aws_apigatewayv2_api" "this" {
  name          = "${var.api_name}"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["*"]
    allow_methods = ["GET", "POST", "DELETE", "OPTIONS"]
    allow_headers = ["Content-Type", "Authorization"]
    expose_headers = ["X-Custom-Header"]
    max_age = 3600
  }
}

//Integration API Gateway -> Lambda
resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

# GET /transactions
resource "aws_apigatewayv2_route" "transactions" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /transactions"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# POST /transactions
resource "aws_apigatewayv2_route" "post_transactions" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "POST /transactions"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# GET /transactions/{transactionId}
resource "aws_apigatewayv2_route" "get_transaction" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /transactions/{transactionId}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# DELETE /transactions/{transactionId}
resource "aws_apigatewayv2_route" "delete_transaction" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "DELETE /transactions/{transactionId}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

# POST /transactions/filteredTransactions
resource "aws_apigatewayv2_route" "filtered_transactions" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "POST /transactions/filteredTransactions"
  target    = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

//Deploy stage (default)
resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true
}

//Lambda permission so API Gateway can invoke it
resource "aws_lambda_permission" "allow_apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.aws_account_id}:${aws_apigatewayv2_api.this.id}/*/*"
}
