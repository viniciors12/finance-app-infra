resource "aws_amplify_app" "this" {
  name                     = var.app_name
  repository               = var.repository
  platform                 = var.platform
  oauth_token = var.github_token
  enable_branch_auto_build = true
  environment_variables    = var.environment_variables
  iam_service_role_arn = var.iam_role_arn 
}

resource "aws_amplify_branch" "main" {
  app_id            = aws_amplify_app.this.id
  branch_name       = var.branch_name
  enable_auto_build = true
}