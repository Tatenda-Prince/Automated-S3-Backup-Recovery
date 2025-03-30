resource "aws_s3_bucket" "backup" {
  bucket = var.backup_bucket
}

resource "aws_s3_bucket" "replica" {
  provider = aws.replica
  bucket   = var.replica_bucket
}

resource "aws_s3_bucket_versioning" "backup" {
  bucket = aws_s3_bucket.backup.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "replica" {
  provider = aws.replica
  bucket   = aws_s3_bucket.replica.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "backup" {
  depends_on = [aws_s3_bucket_versioning.backup]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.backup.id

  rule {
    id     = "replicate-data"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.replica.arn
      storage_class = "STANDARD"
    }
  }
}
