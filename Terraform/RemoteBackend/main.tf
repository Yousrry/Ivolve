
resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.bucket_name 
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
    bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket        = aws_s3_bucket.terraform_state.bucket 
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption 
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.table_name 
  billing_mode = var.payway 
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

}

