output "api_gateway_invoke_url" {
  description = "Public URL for invoking the API Gateway"
  value       = "https://${var.api_locations_domain_name}/locations"
}

output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.locations_api.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.locations_api.arn
}
