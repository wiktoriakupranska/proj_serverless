resource "aws_s3_bucket" "bucket75911" {
  bucket = var.bucketName
}

resource "aws_s3_bucket_acl" "bucket75911" {
  bucket = aws_s3_bucket.bucket75911.id
  acl    = var.aclType
}

resource "aws_s3_object" "bucket75911" {
  bucket = aws_s3_bucket.bucket75911.id
  key    = var.objectKey

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket75911.id

  policy = <<POLICY
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "PublicReadGetObject",
"Effect": "Allow",
"Principal": "*",
"Action": "s3:GetObject",
"Resource": "arn:aws:s3:::bucket75911/*"
}
]
}
POLICY
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = var.policyDocumentPrincipalsType
      identifiers = var.policyDocumentPrincipalsIdentifiers
    }

    actions = var.policyDocumentPrincipalsActions

    resources = [
      aws_s3_bucket.bucket75911.arn,
      "${aws_s3_bucket.bucket75911.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "bucket75911" {
  bucket = aws_s3_bucket.bucket75911.bucket

  index_document {
    suffix = var.indexWebsiteFile
  }

  error_document {
    key = var.errorWebsiteFile
  }

  routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": ""
    }
}]
EOF
}
