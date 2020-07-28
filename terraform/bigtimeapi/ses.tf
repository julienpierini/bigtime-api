# Create and register an ses domain name for lambda

resource "aws_ses_domain_identity" "bigtime_ses" {
  domain = local.domain_name
}

resource "aws_ses_domain_dkim" "bigtime_dkim" {
  domain = aws_ses_domain_identity.bigtime_ses.domain
}

resource "aws_route53_record" "example_amazonses_dkim_record" {
  zone_id = module.aws_route53_zone.bigtime_record.id
  name    = "${element(aws_ses_domain_dkim.bigtime_dkim.dkim_tokens, count.index)}._domainkey.${local.domain_name}"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.bigtime_dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}