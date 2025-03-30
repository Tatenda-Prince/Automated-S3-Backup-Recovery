resource "aws_sns_topic" "backup_failure" {
  name = "backup-failure-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.backup_failure.arn
  protocol  = "email"
  endpoint  = "tatendapmoyo61@gmail.com"  # Directly specify the email here
}

