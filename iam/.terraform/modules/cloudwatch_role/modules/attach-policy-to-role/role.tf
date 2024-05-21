/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

# Iterating over the managed_policy variable and apply
# each managed policy for that particular role.
locals {
  policy_arn = { for s in var.policy_arns : s => s }
}

resource "aws_iam_role_policy_attachment" "managed_role_policy_attachment" {
  for_each   = local.policy_arn
  role       = var.role_name
  policy_arn = each.value
}

# Create Custom Policy for Managing Resources outside of AWS Managed Policy
# Case #1 when the inline_policy value is set and policy name is set
resource "aws_iam_policy" "custom_policy_with_name" {
  count       = var.inline_policy != "" && var.name != null ? 1 : 0
  policy      = var.inline_policy
  name        = var.name
  description = var.description
}

# Case #2 when the inline_policy value is set and policy name is NOT set
resource "aws_iam_policy" "custom_policy_with_prefix" {
  count       = var.inline_policy != "" && var.name == null ? 1 : 0
  policy      = var.inline_policy
  name_prefix = length(var.role_name) > 85 ? format("%s-customer-managed", "${substr(var.role_name, 0, 84)}") : format("%s-customer-managed", var.role_name)
  description = var.description
}

# Attaches the custom policy to the role being managed (var.role_name)
resource "aws_iam_role_policy_attachment" "custom_role_policy_attachment_with_name" {
  count      = var.inline_policy != "" && var.name != null ? 1 : 0
  role       = var.role_name
  policy_arn = aws_iam_policy.custom_policy_with_name[count.index].arn
}

resource "aws_iam_role_policy_attachment" "custom_role_policy_attachment_with_prefix" {
  count      = var.inline_policy != "" && var.name == null ? 1 : 0
  role       = var.role_name
  policy_arn = aws_iam_policy.custom_policy_with_prefix[count.index].arn
}

