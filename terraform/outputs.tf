# outputs.tf

# Output for the SNS topic ARN
output "sns_topic_arn" {
  description = "The ARN of the SNS topic for backup failure notifications"
  value       = aws_sns_topic.backup_failure.arn
}

# Output for the Lambda function name
output "lambda_function_name" {
  description = "The name of the Lambda function used for backup"
  value       = aws_lambda_function.backup_lambda.function_name
}

# Output for the Lambda function ARN
output "lambda_function_arn" {
  description = "The ARN of the Lambda function used for backup"
  value       = aws_lambda_function.backup_lambda.arn
}

# Output for the SNS subscription ARN (if needed)
output "sns_subscription_arn" {
  description = "The ARN of the SNS subscription"
  value       = aws_sns_topic_subscription.email_subscription.arn
}

# Output for IAM Role ARN (Lambda's role)
output "lambda_role_arn" {
  description = "The ARN of the IAM role used by Lambda"
  value       = aws_iam_role.lambda_role.arn
}
