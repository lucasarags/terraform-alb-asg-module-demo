/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "inline_policy" {
  source_policy_documents = [var.inline_policy]

  statement {
    sid = "AllowCreateAndListS3ActionsOnSpecifiedTerraformBucket"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketVersioning",
      "s3:GetObject",
      "s3:GetBucketAcl",
      "s3:GetBucketEncryption",
      "s3:GetBucketLogging",
      "s3:GetBucketPolicy",
      "s3:GetBucketPublicAccessBlock",
      "s3:CreateBucket",
      "s3:PutObject",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketTagging",
      "s3:PutBucketPolicy",
      "s3:PutBucketVersioning",
      "s3:PutEncryptionConfiguration",
      "s3:PutBucketAcl",
      "s3:PutBucketLogging",
    ]
    resources = [
      local.bucket_arn
    ]
  }

  statement {
    sid = "AllowGetAndPutS3ActionsOnSpecifiedTerraformBucketPath"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]
    resources = [
      format("%s/*", local.bucket_arn)
    ]
  }

  statement {
    sid = "AllowCreateAndUpdateDynamoDBActionsOnSpecifiedTerraformTable"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:DescribeTable",
      "dynamodb:DeleteItem",
      "dynamodb:CreateTable",
    ]
    resources = [
      local.dynamodb_arn
    ]
  }
}
