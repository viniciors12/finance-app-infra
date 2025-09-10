environment = "dev"
region      = "us-east-2"
tags = {
  Owner      = "Vinicio"
  Project    = "finance-app-infra-dev"
  Environment = "dev"
}


table_name = "transactions"
hash_key   = "TransactionId"
range_key  = "Date"

attributes = [
  { name = "TransactionId", type = "N" },
  { name = "Date", type = "S" },
]