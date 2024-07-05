#dynamodb for storing data

resource "aws_dynamodb_table" "strength_table" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = var.dynamodb_table_hash_key
  range_key      = var.dynamodb_table_range_key

  attribute {
    name = var.dynamodb_table_hash_key
    type = "S"
  }

  attribute {
    name = var.dynamodb_table_range_key
    type = "S"
  }


  tags = {
    Name = var.dynamodb_table_name
  }
}
