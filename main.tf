module "transactions_table" {
  source     = "./modules/dynamodb"
  table_name = var.table_name
  hash_key   = var.hash_key
  range_key   = var.range_key
  attributes = var.attributes
}

module "iam" {
  source        = "./modules/iam"
  function_name = var.function_name
  table_name     = var.table_name
  table_arn = module.transactions_table.table_arn
  aws_account_id = var.aws_account_id
  region         = var.region
  amplify_role_name = "my-finance-amplify-role"
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = var.function_name
  image_uri     = var.image_uri
  role_arn      = module.iam.lambda_role_arn
}

module "cognito" {
  source        = "./modules/cognito"
  pool_name     = "finance-app-user-pool"
}

module "api_gateway" {
  source     = "./modules/api_gateway"
  api_name   = "${var.function_name}"
  lambda_arn = module.lambda.lambda_arn
  aws_account_id = var.aws_account_id
  region         = var.region
  function_name = var.function_name
  cognito_user_pool_id = module.cognito.cognito_user_pool_id
  cognito_app_client_id = module.cognito.cognito_app_client_id
}

module "amplify" {
  source      = "./modules/amplify"
  app_name    = "my-finance-app"
  repository  = "https://github.com/viniciors12/finance-dashboard-ui.git"
  branch_name = "main"
  github_token = var.github_token //getting it from the env vars
  iam_role_arn  = module.iam.amplify_role_arn
  environment_variables = {
    REACT_APP_API_URL = "https://i8vvaycq2f.execute-api.us-east-2.amazonaws.com"
  }
}

