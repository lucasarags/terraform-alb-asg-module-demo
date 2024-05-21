provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

module "s3_bucket" {
  source = "git::ssh://git@github.azc.ext.hp.com/runway/terraform-aws-s3.git//modules/s3-bucket?ref=v6.3.1"

  bucket             = var.s3_bucket_name
  versioning_enabled = true
  acl                = "private"

  lifecycle_rules = [
    {
      id      = "rule1"
      enabled = true
      prefix  = "rule1/"

      expiration = {
        days = 90
      }
    },
    {
      id      = "rule2"
      enabled = true
      prefix  = "rule2/"

      expiration = {
        days = 90
      }
    },
  ]

  server_side_encryption_configuration = [{
    sse_algorithm = "AES256"
  }]
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = var.dynamodb_table_name
  hash_key       = "LockID"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "LockID"
    type = "S"
  }
}

module "terraform_s3_access_policy" {
  source = "git::ssh://git@github.azc.ext.hp.com/runway/terraform-aws-iam//modules/iam-policy?ref=v5.1.1"
  
  policy_name = "terraform_s3_access_policy"

  policy_document = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:GetObjectVersion",
            "s3:PutObject",
            "s3:DeleteObject",
            "s3:ListBucket"
          ],
          "Resource": [
            "arn:aws:s3:::${var.s3_bucket_name}",
            "arn:aws:s3:::${var.s3_bucket_name}/*"
          ]
        }
      ]
    }
  EOF
}
