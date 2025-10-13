environment = "dev"
region      = "us-east-2"
aws_account_id = "386495806187"
tags = {
  Owner      = "Vinicio"
  Project    = "finance-app-infra-dev"
  Environment = "dev"
}
table_name = "transactions"
hash_key   = "UserId"
range_key    = "TransactionId"
attributes = [
  { name = "TransactionId", type = "S" },
  { name = "UserId", type = "S" },
  { name = "Date", type = "S" },
]
function_name = "finance-dashboard-api"
image_uri     = "386495806187.dkr.ecr.us-east-2.amazonaws.com/finance-dashboard-api:latest"
