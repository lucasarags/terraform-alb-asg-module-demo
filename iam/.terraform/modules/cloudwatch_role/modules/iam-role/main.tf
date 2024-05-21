/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

locals {
  inline_policy       = can(jsondecode(var.inline_policy)) ? var.inline_policy : jsonencode(var.inline_policy)
  inline_policy_count = var.inline_policy == "" ? 0 : 1
  role_name           = var.role_name == "" ? null : var.role_name
  role_prefix         = var.role_name == "" ? var.role_prefix : null
}

resource "aws_iam_role" "role" {
  assume_role_policy    = var.assume_role_policy
  description           = var.role_description
  name                  = local.role_name
  name_prefix           = local.role_prefix
  path                  = var.role_path
  permissions_boundary  = var.permissions_boundary
  max_session_duration  = var.max_session_duration
  tags                  = var.tags
  force_detach_policies = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role_policy" "inline_policy" {
  count = local.inline_policy_count

  role   = aws_iam_role.role.id
  policy = local.inline_policy
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  count = length(var.policy_arns)

  role       = aws_iam_role.role.id
  policy_arn = var.policy_arns[count.index]
}

resource "aws_iam_instance_profile" "profile" {
  count = var.create_instance_profile ? 1 : 0

  name        = local.role_name
  name_prefix = local.role_prefix
  path        = var.role_path
  tags        = var.tags
  role        = aws_iam_role.role.name
}
