output "cloudfront_www_domain_name" {
  value = aws_cloudfront_distribution.www_s3_distribution.domain_name
  description = "Sub domain A record value in Route53"
}

output "cloudfront_root_domain_name" {
  value = aws_cloudfront_distribution.root_s3_distribution.domain_name
  description = "root domain A record value in Route53"
}

output "root_a_record_name" {
  value = aws_route53_record.root-a.fqdn
}

output "www_a_record_name" {
  value = aws_route53_record.www-a.fqdn
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.ssl_certificate.arn
}


output "validation_records_name" {
  value = aws_acm_certificate_validation.cert_validation.validation_record_fqdns
}

output "cert_validation_record_values" {
  value = {
    for k, r in aws_route53_record.cert_validation : k => tolist(r.records)[0]
  }
  description = "The validation record values for the ACM certificate, keyed by the corresponding for_each keys."
}

output "cert_validation_record_names" {
  value = {
    for k, r in aws_route53_record.cert_validation : k => r.name
  }
  description = "The validation record names for the ACM certificate, keyed by the corresponding for_each keys."
}







