variable "environment" {
  type        = string
  description = "Environment name"
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Region"
}

variable "tags" {
  type = map(string)
  description = "tags"
}

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "hash_key" {
  description = "Primary key (hash key) of the table"
  type        = string
}

variable "attributes" {
  description = "Attributes list with name and type"
  type = list(object({
    name = string
    type = string
  }))
}
variable "function_name" {
  description = "Lambda function name"
}

variable "image_uri" {
  description = "Lambda image URI"
}

variable "github_token" {
  type      = string
  sensitive = true
  description = "GitHub PAT for Amplify connection"
  default     = ""
}