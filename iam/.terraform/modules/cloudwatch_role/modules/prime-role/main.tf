/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

locals {
  account_id     = data.aws_caller_identity.current.account_id
  bucket_arn     = format("arn:aws:s3:::%s*%s", local.account_id, var.remote_state_bucket_suffix)
  dynamodb_arn   = format("arn:aws:dynamodb:*:%s:table/*%s", local.account_id, var.remote_state_dynamodb_suffix)
  role_id        = var.role_name == "" ? format("%s*", var.role_prefix) : var.role_name
  prime_boundary = var.permissions_boundary != "" ? var.permissions_boundary : var.set_permissions_boundary ? module.prime_boundary[0].policy_arn : ""

  codeway_projects = [{
    name            = var.codeway_project
    variable_prefix = var.variable_prefix
    variable_group  = format("%s-prime", data.aws_iam_account_alias.current.account_alias)
  }]

  runtime_pb_role_paths    = [for item in var.runtime_permissions_boundary_paths : format("arn:aws:iam::%s:role%s*", local.account_id, item)]
  runtime_pb_user_paths    = [for item in var.runtime_permissions_boundary_paths : format("arn:aws:iam::%s:user%s*", local.account_id, item)]
  runtime_pb_role_prefixes = [for item in var.runtime_permissions_boundary_prefixes : format("arn:aws:iam::%s:role/%s*", local.account_id, item)]
  runtime_pb_user_prefixes = [for item in var.runtime_permissions_boundary_prefixes : format("arn:aws:iam::%s:user/%s*", local.account_id, item)]

  provisioning_pb_role_paths    = [for item in var.provisioning_permissions_boundary_paths : format("arn:aws:iam::%s:role%s*", local.account_id, item)]
  provisioning_pb_user_paths    = [for item in var.provisioning_permissions_boundary_paths : format("arn:aws:iam::%s:user%s*", local.account_id, item)]
  provisioning_pb_role_prefixes = [for item in var.provisioning_permissions_boundary_prefixes : format("arn:aws:iam::%s:role/%s*", local.account_id, item)]
  provisioning_pb_user_prefixes = [for item in var.provisioning_permissions_boundary_prefixes : format("arn:aws:iam::%s:user/%s*", local.account_id, item)]

  irsa_operator_pb_role_paths    = [for item in var.irsa_operator_permissions_boundary_paths : format("arn:aws:iam::%s:role%s*", local.account_id, item)]
  irsa_operator_pb_user_paths    = [for item in var.irsa_operator_permissions_boundary_paths : format("arn:aws:iam::%s:user%s*", local.account_id, item)]
  irsa_operator_pb_role_prefixes = [for item in var.irsa_operator_permissions_boundary_prefixes : format("arn:aws:iam::%s:role/%s*", local.account_id, item)]
  irsa_operator_pb_user_prefixes = [for item in var.irsa_operator_permissions_boundary_prefixes : format("arn:aws:iam::%s:user/%s*", local.account_id, item)]
}

module "prime_boundary" {
  source = "../iam-policy"
  count  = var.set_permissions_boundary ? 1 : 0

  policy_name        = var.prime_permissions_boundary_name
  policy_document    = data.aws_iam_policy_document.prime_boundary.json
  policy_description = "Permissions boundary for Runway prime roles"
}

module "provisioning_boundary" {
  source = "../iam-policy"
  count  = var.set_permissions_boundary ? 1 : 0

  policy_name        = var.provisioning_permissions_boundary_name
  policy_document    = data.aws_iam_policy_document.provisioning_boundary.json
  policy_description = "Permissions boundary for Runway provisioning roles"
}

module "runtime_boundary" {
  source = "../iam-policy"
  count  = var.set_permissions_boundary ? 1 : 0

  policy_name        = var.runtime_permissions_boundary_name
  policy_document    = data.aws_iam_policy_document.runtime_boundary.json
  policy_description = "Permissions boundary for Runway runtime roles"
}

module "irsa_operator_boundary" {
  source = "../iam-policy"
  count  = var.set_permissions_boundary ? 1 : 0

  policy_name        = var.irsa_operator_permissions_boundary_name
  policy_document    = data.aws_iam_policy_document.irsa_operator_boundary.json
  policy_description = "Permissions boundary for Runway IRSA operator roles"
}

module "codeway_role" {
  source = "../codeway-role"

  codeway_projects     = local.codeway_projects
  inline_policy        = data.aws_iam_policy_document.inline_policy.json
  max_session_duration = var.max_session_duration
  policy_arns          = var.additional_policy_arns
  role_name            = var.role_name
  role_prefix          = var.role_prefix
  role_path            = var.role_path
  permissions_boundary = local.prime_boundary
}
