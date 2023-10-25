resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid        = var.user_uuid
    Hello = "marss"
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
# resource "aws_s3_object" "index_html" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "index.html"
#   source = "${path.root}${var.index_html_filepath}"
#   content_type = "text/html"

#   # The filemd5() function is available in Terraform 0.11.12 and later
#   # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
#   # etag = "${md5(file("path/to/file"))}"
#   etag = filemd5("${path.root}${var.index_html_filepath}")
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object
# resource "aws_s3_object" "error" {
#   bucket = aws_s3_bucket.website_bucket.bucket
#   key    = "error.html"
#   source = "${path.root}${var.error_html_filepath}"
#   content_type = "text/html"


#   # The filemd5() function is available in Terraform 0.11.12 and later
#   # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
#   # etag = "${md5(file("path/to/file"))}"
#   etag = filemd5("${path.root}${var.error_html_filepath}")
# }

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.bucket
  # policy = data.aws_iam_policy_document.allow_access_from_another_account.json
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
      "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action" = "s3:GetObject",
      "Resource" = "arn:aws:s3:::${aws_s3_bucket.website_bucket.id}/*",
      # "Condition" = {
      # "StringEquals" = {
      #     "AWS:SourceArn" = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"
      #     # "AWS:SourceArn": data.aws_caller_identity.current.arn
      #   }
      # }
    }    
  })
}