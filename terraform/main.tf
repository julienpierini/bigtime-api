# Configure S3 backend

terraform {
  backend "s3" {
    bucket = "terraform-tfstate"
    key    = "bigtime-api/terraform.tfstate"
    region = "eu-west-1"        
  }
}


# Call to bigtimeapi module

module "bigtimeapi" {
  source = "./bigtimeapi"
}