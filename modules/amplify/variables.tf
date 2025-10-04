variable "app_name" {
  type        = string
  description = "Amplify app name"
}

variable "repository" {
  type        = string
  description = "Github URL"
}

variable "platform" {
  type        = string
  default     = "WEB"
}

variable "branch_name" {
  type        = string
  default     = "main"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
}

variable "github_token" {
  type        = string
  description = "GitHub personal access token"
  sensitive   = true
  default     = ""
}

variable "iam_role_arn" {
  type        = string
  description = "IAM Role ARN for Amplify builds"
}