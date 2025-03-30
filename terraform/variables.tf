variable "aws_region" {
  description = "Primary AWS region"
  default     = "us-east-1"
}

variable "replica_region" {
  description = "Secondary AWS region for replication"
  default     = "us-west-2"
}

variable "backup_bucket" {
  description = "Primary S3 bucket for backups"
  default     = "tatenda-source-bucket"
}

variable "replica_bucket" {
  description = "Replica S3 bucket in another region"
  default     = "tatenda-replica-bucket"
}

variable "lambda_role_name" {
  description = "IAM role for Lambda functions"
  default     = "s3_backup_lambda_role"
}

variable "sns_topic_name" {
  description = "SNS topic for backup alerts"
  default     = "s3-backup-alerts"
}
