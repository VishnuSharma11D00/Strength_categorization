provider "aws" { 
  region = "us-east-1"
}

module "dynamodb" {
  source = "./modules/dynamodb"

  dynamodb_table_name = local.dynamodb_table_name
  dynamodb_table_hash_key = local.dynamo_db_table_hash_key
  dynamodb_table_range_key = local.dynamodb_table_range_key
}

module "lambda" {
    source = "./modules/lambda"

  lambda_iam_role_name = local.lambda_role_name
  dynamodb_arn = module.dynamodb.dynamodb_table_arn
  dynamodb_table_name = local.dynamodb_table_name

  python_code_path = local.python_code_path
  output_zip_name = local.output_zip_name
  python_zip_path = local.python_zip_path

  lambda_function_name = local.lambda_function_name
  lambda_handler = local.lambda_handler
  lambda_runtime = local.lambda_runtime

}

module "lambda_history" {
  source = "./modules/lambda"

  lambda_iam_role_name = local.lambda_history_iam_role_name
  dynamodb_arn = module.dynamodb.dynamodb_table_arn
  dynamodb_table_name = local.dynamodb_table_name

  python_code_path = local.python_historycode_path
  python_zip_path = local.python_historycode_zip_path
  output_zip_name = local.python_historycode_zip_output_path

  lambda_function_name = local.lambda_history_function_name
  lambda_handler = local.lambda_history_function_handler
  lambda_runtime = local.lambda_history_function_runtime
}
/*
module "api-gateway" {
  source = "./modules/api-gateway"

  rest_api_gateway_name = local.api_gateway_name
  region = local.region
  lambda_function_arn = module.lambda.lambda_arn
  api_gateway_stage_name = local.api_gateway_stage_name
  
  depends_on = [module.lambda]
  }
*/

module "aws_amplify" {
  source = "./modules/AWS-Amplify"

  git_repo = local.git_repo
  github_access_token = local.github_access_token
  app_name = local.app_name
  API_GATEWAY_URL_root = local.api_gateway_stage_url     # module.api-gateway.root_url (api-gateway cors did not work through terraform)
  API_GATEWAY_URL_history = local.api_gateway_stage_url_history
  # depends_on = [ module.api-gateway ]
}
