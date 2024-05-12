terraform {
  backend "s3" {
    bucket  = "jptf-state-bucket"
    key     = "state-files/terraform.tfstate"
    region  = "us-east-1"
    profile = "terraform"
  }
}