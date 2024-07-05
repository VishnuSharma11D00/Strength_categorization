# api gateway stage url

output "root_url" {
  value = "${aws_api_gateway_stage.example.invoke_url}//root"
}

output "history_url" {
  value = "${aws_api_gateway_stage.example.invoke_url}/history"
}