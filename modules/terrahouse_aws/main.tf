terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.18.1"
    }
  }
}

resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid        = var.user_uuid
  }
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.root}/public/index.html")
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error.html"
  source = "${path.root}/public/error.html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${path.root}/public/error.html")
}
