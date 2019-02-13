terraform {
  backend "s3" {
    bucket = "xerox-terraform-state-storage"
    key    = "xerox-price-file-processor/terraform.tfstate"
    region = "eu-west-1"
  }
}
