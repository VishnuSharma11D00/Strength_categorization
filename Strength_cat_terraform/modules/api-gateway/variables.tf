variable "rest_api_gateway_name" {
  description = "name of the api gateway"
  type = string
}

variable "region" {
    description = "AWS region where the resources will be deployed"
    type        = string
}

variable "lambda_function_arn" {
  description = "The URI of the Lambda function to integrate with the API Gateway"
  type        = string
}

variable "api_gateway_stage_name" {
  description = "Stage name of the api gateway"
  type        = string
}