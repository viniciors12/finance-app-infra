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