module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "v0.2.0"

  name          = "bigtime-apigateway"
  description   = "Bigtime API Gateway"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["GET"]
    allow_origins = ["*"]
  }

  # Custom domain
  domain_name                 = local.domain_name
  domain_name_certificate_arn = module.acm.this_acm_certificate_arn

  # Access logs
  default_stage_access_log_destination_arn = "arn:aws:logs:${var.region}:${var.account_id}:log-group:accesslog-apigateway"
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "GET /currentTime" = {
      lambda_arn             = module.lambda_bigtime.this_lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 60
    }

    "$default" = {
      lambda_arn = module.lambda_bigtime.this_lambda_function_arn
    }
  }

  tags = {
    Name = "bigtime-apigateway"
    App  = "bigtime"
  }
}


# ACM for domain's certificates

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "v2.9.0"

  domain_name               = local.domain_name
  zone_id                   = module.aws_route53_zone.bigtime_record.id
  subject_alternative_names = ["${local.subdomain}.${local.domain_name}"]
}

# Route53

resource "aws_route53_record" "bigtime_record" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = local.subdomain
  type    = "A"

  alias {
    name                   = module.api_gateway.this_apigatewayv2_domain_name_configuration.0.target_domain_name
    zone_id                = module.api_gateway.this_apigatewayv2_domain_name_configuration.0.hosted_zone_id
    evaluate_target_health = false
  }
}