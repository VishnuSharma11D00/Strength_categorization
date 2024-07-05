# lambda function arn
output "lambda_arn" {
    value = aws_lambda_function.strength_categorization.arn
}