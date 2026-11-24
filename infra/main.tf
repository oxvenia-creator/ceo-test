terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Intentional misconfiguration for test scan: public access, no SSE encryption, no versioning
resource "aws_s3_bucket" "ceo_test_artifacts" {
  bucket = "oxvenia-ceo-test-artifacts-bucket"

  tags = {
    Environment = "test"
    Owner       = "invinciblemax0@gmail.com"
    Purpose     = "oxvenia-iac-ceo-eval"
  }
}

resource "aws_s3_bucket_public_access_block" "ceo_test_artifacts_pab" {
  bucket = aws_s3_bucket.ceo_test_artifacts.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Intentional misconfiguration for test scan: unrestricted ingress on SSH (22)
resource "aws_security_group" "ceo_test_ssh" {
  name        = "oxvenia-ceo-test-ssh-sg"
  description = "Test security group for Oxvenia IaC scan"

  ingress {
    description = "Open SSH for test evaluation"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Intentional misconfiguration for test scan: unencrypted RDS database
resource "aws_db_instance" "ceo_test_db" {
  allocated_storage = 20
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  username          = "appuser"
  password          = "ChangeMeInTestOnly123!"
  storage_encrypted = false
  skip_final_snapshot = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ceo_test_artifacts" {
  bucket = aws_s3_bucket.ceo_test_artifacts.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
      bucket_key_enabled = true
    }
    bucket_key_enabled = true
  }
}