terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

######################### S3 #########################
resource "aws_s3_bucket" "this" {

  bucket = var.bucket_name

  tags = {
    Name = "${var.bucket_name}"
  }
}
######################### Bucket Ownership  #########################
resource "aws_s3_bucket_ownership_controls" "owner" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

######################### Bucket access ploicy  #########################
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

######################### Bucket ACL  #########################
resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.owner,
    aws_s3_bucket_public_access_block.public_access,
  ]

  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}