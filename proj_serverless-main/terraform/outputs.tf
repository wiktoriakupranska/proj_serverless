output "bucket_domain_name" {
  value       = aws_s3_bucket.bucket75911.*.bucket_domain_name
  description = "FQDN of bucket"
}

output "bucket_website_endpoint" {
  value       = aws_s3_bucket_website_configuration.bucket75911.*.website_endpoint
  description = "The bucket website endpoint, if website is enabled"
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket75911.*.arn
  description = "Bucket ARN"
}

