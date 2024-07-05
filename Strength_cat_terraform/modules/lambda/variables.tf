variable "lambda_iam_role_name" {
  description = "name of the iam role for the lambda function"
}


variable "dynamodb_arn" {
  description = "output from dynamodb table"
}

variable "python_code_path" {
  description = "path of the file or directory of the python code"
}

variable "output_zip_name" {
  description = "name of the zip file that will be created"
}

variable "python_zip_path" {
  description = "path of the file or dir of the output zip file"
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "The handler for the Lambda function"   #strength_cat_lambda_function.lambda_handler
  type        = string
}

variable "lambda_runtime" {
  description = "The runtime for the Lambda function"
  type        = string
}


variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

