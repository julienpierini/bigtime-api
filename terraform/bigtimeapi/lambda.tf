# Lambda for the bigtime api gateway 

module "lambda_bigtime" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "v1.17.0"

  function_name = "bigtime-lambda"
  description   = "Bigtime lambda function"
  handler       = "main.handler"
  runtime       = "python3.8"

  source_path = "./src/main.py"

  attach_policy_json = true
  policy_json        = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ses:SendEmail"
                "ses:ListVerifiedEmailAddresses"
                "ses:ListIdentities"
            ],
            "Resource": ["${aws_ses_domain.bigtime_ses.arn}"]
        }
    ]
}
EOF

  tags = {
    Name = "bigtime-lambda"
    App  = "bigtime"
  }
}