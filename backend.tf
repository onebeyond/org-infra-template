terraform {
  backend "s3" {
    bucket = "github-terraform-state"
    key    = "state/terraform.tfstate"
    region = "eu-west-2"
  }
}
