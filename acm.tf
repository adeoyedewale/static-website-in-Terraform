resource "aws_acm_certificate" "ssl_certificate" {
  provider                  = aws.acm_provider
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  #validation_record_fqdns = aws_route53_record.cert_validation.*.name_servers
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}