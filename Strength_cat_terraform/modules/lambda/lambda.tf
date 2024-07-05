# IAM role for lambda function

resource "aws_iam_role" "lambda_role" {
  name = var.lambda_iam_role_name

  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# Policy to allow Lambda to access DynamoDB
resource "aws_iam_role_policy" "lambda_dynamodb_policy" {
  name   = "lambda_dynamodb_policy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_dynamodb_policy.json
}

# Generate an archive .zip file

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir = var.python_code_path
  output_path = var.output_zip_name
}
resource "aws_lambda_function" "strength_categorization" {
  function_name = var.lambda_function_name
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler
  filename      = var.python_zip_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      DYNAMODB_TABLE_NAME = var.dynamodb_table_name
    }
  }

  depends_on = [ data.archive_file.lambda_zip, aws_iam_role_policy.lambda_dynamodb_policy ]
  
}

