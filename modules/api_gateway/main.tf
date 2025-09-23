//API Gateway HTTP API
resource "aws_apigatewayv2_api" "this" {
  name          = "${var.api_name}"
  protocol_type = "HTTP"
}

//Integration API Gateway -> Lambda
resource "aws_apigatewayv2_integration" "lambda" {
  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = "AWS_PROXY"
  integration_uri        = var.lambda_arn
  integration_method     = "POST"
  payload_format_version = "2.0"
}

//Route: GET /transactions
resource "aws_apigatewayv2_route" "transactions" {
  api_id    = aws_apigatewayv2_api.this.id
  route_key = "GET /transactions"
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
  source_arn    = "arn:aws:execute-api:${var.region}:${var.aws_account_id}:${aws_apigatewayv2_api.this.id}/$default/GET/transactions"
}
