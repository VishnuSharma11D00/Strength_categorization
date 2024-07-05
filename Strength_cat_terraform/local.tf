locals {
  #dynamo db variables
  dynamodb_table_name = "strength_cat_dynamodb"
  dynamo_db_table_hash_key = "username"
  dynamodb_table_range_key = "timestamp"


  #lambda variables
  lambda_role_name = "lambda_execution_role"

  lambda_function_name = "strength_cat_lambda"
  lambda_runtime = "python3.12"
  lambda_handler = "strenCat_lambda_fun_percentage.lambda_handler" #the lambda-file-name.lambda_handler"
  python_code_path = "modules/python_code/"
  output_zip_name = "modules/python_code/lambda.zip"
  python_zip_path = "modules/python_code/lambda.zip"


  #lambda history fuction variables
  lambda_history_iam_role_name = "lambda_history_execution_role"

  lambda_history_function_name = "strength_cat_lambda_history"
  lambda_history_function_runtime = "python3.12"
  lambda_history_function_handler = "history_lambda_code.lambda_handler" #the lambda-file-name.lambda_handler"
  python_historycode_path = "modules/python_code_history/"
  python_historycode_zip_path = "modules/python_code_history/lambda_history.zip"
  python_historycode_zip_output_path = "modules/python_code_history/lambda_history.zip"


  # api-gateway variables
  api_gateway_name = "strength_cat_apigateway"
  api_gateway_stage_name = "dev"
  region = "us-east-1"


  # Amplify variables
  git_repo = "https://github.com/VishnuSharma11D00/Strength_categorization.git"
  github_access_token = "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"
  app_name = "strength_cat"
}