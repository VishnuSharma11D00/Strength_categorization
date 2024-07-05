variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "dynamodb_table_hash_key" {
  description = "Hash key for the DynamoDB table"
  type        = string
}

variable "dynamodb_table_range_key" {
  description = "Range key for the DynamoDB table"
  type        = string
}
