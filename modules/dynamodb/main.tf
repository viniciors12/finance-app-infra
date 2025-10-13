resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key
  range_key     = var.range_key

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }
  
  global_secondary_index {
    name               = "UserId-Date-index"
    hash_key           = "UserId"
    range_key          = "Date"
    projection_type    = "ALL"
  }
}