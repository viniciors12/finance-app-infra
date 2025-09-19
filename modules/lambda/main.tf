resource "aws_lambda_function" "this" {
  function_name = var.function_name
  package_type  = "Image"
  image_uri     = var.image_uri
  role          = var.role_arn
  timeout       = var.timeout
  memory_size   = var.memory_size
}
