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
