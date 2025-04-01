resource "aws_iam_role" "replication" {
  name = "s3_replication_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "s3.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "replication_policy" {
  name        = "s3_replication_policy"
  description = "Allows S3 replication from primary to replica bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:ReplicateObject", "s3:ReplicateDelete", "s3:ReplicateTags"]
      Resource = [
        "arn:aws:s3:::${var.backup_bucket}/*",
        "arn:aws:s3:::${var.replica_bucket}/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_replication_policy" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication_policy.arn
}


## lambda iam role
## Lambda IAM Role
resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

## Fetch AWS Account ID Dynamically
data "aws_caller_identity" "current" {}

## Lambda IAM Policy with S3 & SNS Permissions
resource "aws_iam_policy" "lambda_s3_policy" {
  name        = "lambda_s3_backup_policy"
  description = "Allows Lambda to read from the backup bucket, write to the replica bucket, and send SNS notifications"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Resource = [
          "arn:aws:s3:::${var.backup_bucket}",
          "arn:aws:s3:::${var.backup_bucket}/*"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject"]
        Resource = [
          "arn:aws:s3:::${var.replica_bucket}/*"
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect   = "Allow"
        Action   = ["sns:Publish"]
        Resource = "arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:backup-failure-topic"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_lambda_s3_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}

