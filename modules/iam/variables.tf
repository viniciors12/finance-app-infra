variable "region" {}
variable "aws_account_id" {}
variable "table_name" {}
variable "function_name" {}
variable "amplify_role_name" {
  type        = string
  description = "Amplify IAM Role name"
  default     = "amplify-build-role"
}
variable "table_arn" {
  description = "DynamoDB table arn"
  type        = string
}