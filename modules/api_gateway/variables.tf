variable "lambda_arn" {
  description = "lambda ARN that will integrate the API Gateway"
  type        = string
}

variable "api_name" {
  type        = string
}

variable "function_name" {
  description = "lambda function name"
  type        = string
}

variable "region" {
  type        = string
}

variable "aws_account_id" {
  type        = string
}

variable "cognito_app_client_id" {
  description = "cognito app client id"
  type        = string
}

variable "cognito_user_pool_id" {
  description = "cognito app pool id"
  type        = string
}
