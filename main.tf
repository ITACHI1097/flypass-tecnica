

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_s3_bucket" "test-terraform" {
  bucket  = "test-terraform"
  acl = "private"
  tags    = {
	Name          = "MyS3Bucket"
	Environment    = "Production"
  Username       = "daniel.munoz"
  }
}

