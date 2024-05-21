/*
 * (C) Copyright 2019-2023 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

module "role" {
  source = "../iam-role"

  role_name            = var.role_name
  role_prefix          = var.role_prefix
  role_description     = var.role_description
  role_path            = var.role_path
  inline_policy        = var.inline_policy
  max_session_duration = var.max_session_duration
  policy_arns          = var.policy_arns
  permissions_boundary = var.permissions_boundary
  tags                 = var.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
}

resource "random_password" "external_id" {
  length           = 10
  override_special = "=,.@:-"
}
