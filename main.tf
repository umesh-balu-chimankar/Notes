terraform {
  backend "s3" {
    bucket = "amzn-tf-s3"
    region = "ap-south-1"
    key = "tfstate"
  }
}
