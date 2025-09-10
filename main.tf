module "transactions_table" {
  source     = "./modules/dynamodb"
  table_name = var.table_name
  hash_key   = var.hash_key
  range_key  = var.range_key
  attributes = var.attributes
}