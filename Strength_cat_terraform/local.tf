locals {
  #dynamo db variables
  dynamodb_table_name = "strength_cat_dynamodb"                                   # name of your dynamodb
  dynamo_db_table_hash_key = "username"
  dynamodb_table_range_key = "timestamp"


  #lambda variables
  lambda_role_name = "lambda_execution_role"   #name of your lambda execution role

  lambda_function_name = "strength_cat_lambda"    #name of your lambda function
  lambda_runtime = "python3.12"
  lambda_handler = "strenCat_lambda_fun_percentage.lambda_handler"                  # name of lambda-file-name.lambda_handler"
  python_code_path = "modules/python_code/"                                         # location of the python code
  output_zip_name = "modules/python_code/lambda.zip"                                # name your zip file for the function that will be created
  python_zip_path = "modules/python_code/lambda.zip"                                # should be same as above


  #lambda history fuction variables
  lambda_history_iam_role_name = "lambda_history_execution_role"                     # name of your lambda history function execution role

  lambda_history_function_name = "strength_cat_lambda_history"                       # name of your lambda history function 
  lambda_history_function_runtime = "python3.12"                                     
  lambda_history_function_handler = "history_lambda_code.lambda_handler"             #the lambda-history-file-name.lambda_handler"
  python_historycode_path = "modules/python_code_history/"                           # location of the python code
  python_historycode_zip_path = "modules/python_code_history/lambda_history.zip"     # name your zip file for the history function that will be created
  python_historycode_zip_output_path = "modules/python_code_history/lambda_history.zip"  # should be same as above
 

  # api-gateway variables
  api_gateway_name = "strength_cat_apigateway"                                       # api gateway name
  api_gateway_stage_name = "dev"                                                     # api gateway stage name
  region = "us-east-1"                                                               # Region


  # Amplify variables
  git_repo = "----------------------------------------------------------------"      # your git repo
  github_access_token = "-----------------------------------------------------"      # your git hub access token
  app_name = "strength_cat"                                                          # name of your app
  api_gateway_stage_url = "https://------------------------"                         # api gateway stage url path /root
  api_gateway_stage_url_history = "https://------------------------"                 # api gateway stage url path /history
}
