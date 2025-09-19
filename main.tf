module "transactions_table" {
  source     = "./modules/dynamodb"
  table_name = var.table_name
  hash_key   = var.hash_key
  attributes = var.attributes
}

module "iam" {
  source        = "./modules/iam"
  function_name = var.function_name
  table_name     = var.table_name
  aws_account_id = var.aws_account_id
  region         = var.region
}

module "lambda" {
  source        = "./modules/lambda"
  function_name = var.function_name
  image_uri     = var.image_uri
  role_arn      = module.iam.lambda_role_arn
}

module "api_gateway" {
  source     = "./modules/api_gateway"
  api_name   = "${var.function_name}"
  lambda_arn = module.lambda.lambda_arn
  aws_account_id = var.aws_account_id
  region         = var.region
  function_name = var.function_name
}
