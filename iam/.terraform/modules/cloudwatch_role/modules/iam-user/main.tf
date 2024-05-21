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
  user_name           = var.user_name == "" ? null : var.user_name
}

resource "aws_iam_user" "user" {
  name                 = local.user_name
  path                 = var.user_path
  permissions_boundary = var.permissions_boundary

  tags = var.tags
}

resource "aws_iam_user_policy" "inline_policy" {
  count = local.inline_policy_count

  user   = aws_iam_user.user.name
  policy = local.inline_policy
}

resource "aws_iam_user_policy_attachment" "managed_policy" {
  count = length(var.policy_arns)

  user       = aws_iam_user.user.name
  policy_arn = var.policy_arns[count.index]
}
