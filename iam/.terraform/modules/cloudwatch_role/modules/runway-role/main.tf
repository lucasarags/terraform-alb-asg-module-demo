/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

locals {
  account_id   = data.aws_caller_identity.current.account_id
  bucket_arn   = format("arn:aws:s3:::%s*%s", local.account_id, var.remote_state_bucket_suffix)
  dynamodb_arn = format("arn:aws:dynamodb:*:%s:table/*%s", local.account_id, var.remote_state_dynamodb_suffix)
}

module "codeway_role" {
  source = "../codeway-role"

  codeway_projects     = var.codeway_projects
  inline_policy        = data.aws_iam_policy_document.inline_policy.json
  max_session_duration = var.max_session_duration
  policy_arns          = var.additional_policy_arns
  permissions_boundary = var.permissions_boundary
  role_name            = var.role_name
  role_prefix          = var.role_prefix
  role_path            = var.role_path
  tags                 = var.tags
}
