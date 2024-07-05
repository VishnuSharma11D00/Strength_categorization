#dynamodb arn output

output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB table"
  value = aws_dynamodb_table.strength_table.arn
}