resource "aws_lambda_function" "backup_lambda" {
  function_name = "s3_backup_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "backup_function.lambda_handler"
  runtime       = "python3.9"
  timeout       = 30

  filename         = "../lambda.zip"
  source_code_hash = filebase64sha256("../lambda.zip")

  environment {
    variables = {
      REPLICA_BUCKET = var.replica_bucket
      SNS_TOPIC_ARN  = aws_sns_topic.backup_failure.arn
    }
  }
}



resource "aws_s3_bucket_notification" "s3_event_trigger" {
  bucket = aws_s3_bucket.backup.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.backup_lambda.arn
    events             = ["s3:ObjectCreated:*"]
  }
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.backup_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.backup.arn
}
