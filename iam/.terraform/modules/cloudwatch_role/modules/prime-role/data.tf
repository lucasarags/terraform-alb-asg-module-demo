/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

data "aws_caller_identity" "current" {}

data "aws_iam_account_alias" "current" {}

data "aws_iam_policy_document" "inline_policy" {
  source_policy_documents = [var.inline_policy]

  statement {
    sid = "IAM"
    actions = [
      "iam:Get*",
      "iam:List*",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:GetServiceLinkedRoleDeletionStatus",
      "iam:CreateServiceLinkedRole",
      "iam:DeleteServiceLinkedRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:UpdateRole*",
      "iam:UpdateAssumeRolePolicy",
    ]
    resources = [
      format("arn:aws:iam::%s:role/*", local.account_id),
      format("arn:aws:iam::%s:policy/*", local.account_id),
    ]
  }

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

  statement {
    sid = "AllowDescribeEKSClusters"
    actions = [
      "eks:DescribeCluster"
    ]
    resources = [
      format("arn:aws:eks:*:%s:cluster/*", local.account_id)
    ]
  }

}

data "aws_iam_policy_document" "prime_boundary" {
  statement {
    sid       = "AllowAccess"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyPrimeMisuse"
    effect = "Deny"
    not_actions = [
      "iam:*",
      "s3:*",
      "dynamodb:*",
      "eks:DescribeCluster",
    ]
    resources = ["*"]
  }

  statement {
    sid    = "DenyBoundaryAlteration"
    effect = "Deny"
    actions = [
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion",
    ]
    resources = [
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.prime_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.provisioning_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
    ]
  }

  statement {
    sid    = "DenyRemovalOfBoundaryFromAnyUserOrRole"
    effect = "Deny"
    actions = [
      "iam:DeleteUserPermissionsBoundary",
      "iam:DeleteRolePermissionsBoundary",
    ]
    resources = [
      format("arn:aws:iam::%s:user/*", local.account_id),
      format("arn:aws:iam::%s:role/*", local.account_id),
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.prime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.provisioning_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
      ]
    }
  }

  statement {
    sid    = "DenyAccessIfBoundaryIsNotApplied"
    effect = "Deny"
    actions = [
      "iam:AttachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:DeleteRolePolicy",
      "iam:DeleteUserPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
      "iam:PutRolePermissionsBoundary",
      "iam:PutUserPermissionsBoundary",
      "iam:PutRolePolicy",
      "iam:PutUserPolicy"
    ]
    resources = [
      format("arn:aws:iam::%s:user/*", local.account_id),
      format("arn:aws:iam::%s:role/*", local.account_id),
    ]
    condition {
      test     = "StringNotEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.prime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.provisioning_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
      ]
    }
  }

  statement {
    sid    = "DenyAccessIfNotOnPathOrPrefix"
    effect = "Deny"
    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:DeactivateMFADevice",
      "iam:DeleteAccessKey",
      "iam:DeleteRole",
      "iam:DeleteUser",
      "iam:EnableMFADevice",
      "iam:PassRole",
      "iam:TagRole",
      "iam:TagUser",
      "iam:UntagRole",
      "iam:UntagUser",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
      "iam:UpdateUser",
      "iam:UploadSigningCertificate",
      "iam:UploadSSHPublicKey"
    ]
    not_resources = concat(
      local.provisioning_pb_role_paths,
      local.provisioning_pb_user_paths,
      local.provisioning_pb_role_prefixes,
      local.provisioning_pb_user_prefixes,
    )
  }
}

data "aws_iam_policy_document" "provisioning_boundary" {
  statement {
    sid       = "AllowAccess"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyPrimeAlteration"
    effect = "Deny"
    actions = [
      "iam:*",
    ]
    resources = [
      format("arn:aws:iam::%s:role%s%s", local.account_id, var.role_path, local.role_id),
    ]
  }

  statement {
    sid    = "DenyBoundaryAlteration"
    effect = "Deny"
    actions = [
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion",
    ]
    resources = [
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.prime_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.provisioning_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
    ]
  }

  statement {
    sid    = "DenyRemovalOfBoundaryFromAnyUserOrRole"
    effect = "Deny"
    actions = [
      "iam:DeleteUserPermissionsBoundary",
      "iam:DeleteRolePermissionsBoundary",
    ]
    resources = [
      format("arn:aws:iam::%s:user/*", local.account_id),
      format("arn:aws:iam::%s:role/*", local.account_id),
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.prime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.provisioning_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
      ]
    }
  }

  statement {
    sid    = "DenyAccessIfBoundaryIsNotApplied"
    effect = "Deny"
    actions = [
      "iam:AttachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:DeleteRolePolicy",
      "iam:DeleteUserPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
      "iam:PutRolePermissionsBoundary",
      "iam:PutUserPermissionsBoundary",
      "iam:PutRolePolicy",
      "iam:PutUserPolicy"
    ]
    resources = [
      format("arn:aws:iam::%s:user/*", local.account_id),
      format("arn:aws:iam::%s:role/*", local.account_id),
    ]
    condition {
      test     = "StringNotEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
      ]
    }
  }

  statement {
    sid    = "DenyAccessIfNotOnPathOrPrefix"
    effect = "Deny"
    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:DeactivateMFADevice",
      "iam:DeleteAccessKey",
      "iam:DeleteRole",
      "iam:DeleteUser",
      "iam:EnableMFADevice",
      "iam:PassRole",
      "iam:TagRole",
      "iam:TagUser",
      "iam:UntagRole",
      "iam:UntagUser",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
      "iam:UpdateUser",
      "iam:UploadSigningCertificate",
      "iam:UploadSSHPublicKey"
    ]
    not_resources = concat(
      local.runtime_pb_role_paths,
      local.runtime_pb_user_paths,
      local.runtime_pb_role_prefixes,
      local.runtime_pb_user_prefixes,
    )
  }
}

data "aws_iam_policy_document" "runtime_boundary" {
  statement {
    sid       = "AllowAccess"
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyAccessToIAM"
    effect = "Deny"
    actions = [
      "iam:Add*",
      "iam:Attach*",
      "iam:ChangePassword",
      "iam:Create*",
      "iam:DeactivateMFADevice",
      "iam:Delete*",
      "iam:Detach*",
      "iam:EnableMFADevice",
      "iam:PassRole",
      "iam:Put*",
      "iam:Remove*",
      "iam:ResetServiceSpecificCredential",
      "iam:ResyncMFADevice",
      "iam:Set*",
      "iam:Tag*",
      "iam:Untag*",
      "iam:Update*",
      "iam:Upload*",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "irsa_operator_boundary" {
  statement {
    sid       = "AllowIAMAccess"
    effect    = "Allow"
    actions   = ["iam:*"]
    resources = ["*"]
  }

  statement {
    sid    = "DenyPrimeAlteration"
    effect = "Deny"
    actions = [
      "iam:*",
    ]
    resources = [
      format("arn:aws:iam::%s:role%s%s", local.account_id, var.role_path, local.role_id),
    ]
  }

  statement {
    sid    = "DenyBoundaryAlteration"
    effect = "Deny"
    actions = [
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:SetDefaultPolicyVersion",
    ]
    resources = [
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.prime_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.provisioning_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
      format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
    ]
  }

  statement {
    sid    = "DenyRemovalOfBoundaryFromAnyUserOrRole"
    effect = "Deny"
    actions = [
      "iam:DeleteUserPermissionsBoundary",
      "iam:DeleteRolePermissionsBoundary",
    ]
    resources = [
      format("arn:aws:iam::%s:user/*", local.account_id),
      format("arn:aws:iam::%s:role/*", local.account_id),
    ]
    condition {
      test     = "StringEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.prime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.provisioning_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.irsa_operator_permissions_boundary_name),
      ]
    }
  }

  statement {
    sid    = "DenyAccessIfBoundaryIsNotApplied"
    effect = "Deny"
    actions = [
      "iam:AttachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:DeleteRolePolicy",
      "iam:DeleteUserPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
      "iam:PutRolePermissionsBoundary",
      "iam:PutUserPermissionsBoundary",
      "iam:PutRolePolicy",
      "iam:PutUserPolicy"
    ]
    resources = [
      format("arn:aws:iam::%s:user/*", local.account_id),
      format("arn:aws:iam::%s:role/*", local.account_id),
    ]
    condition {
      test     = "StringNotEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        format("arn:aws:iam::%s:policy/%s", local.account_id, var.runtime_permissions_boundary_name),
      ]
    }
  }

  statement {
    sid    = "DenyAccessIfNotOnPathOrPrefix"
    effect = "Deny"
    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:CreateRole",
      "iam:CreateUser",
      "iam:DeactivateMFADevice",
      "iam:DeleteAccessKey",
      "iam:DeleteRole",
      "iam:DeleteUser",
      "iam:EnableMFADevice",
      "iam:PassRole",
      "iam:TagRole",
      "iam:TagUser",
      "iam:UntagRole",
      "iam:UntagUser",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
      "iam:UpdateUser",
      "iam:UploadSigningCertificate",
      "iam:UploadSSHPublicKey"
    ]
    not_resources = concat(
      local.irsa_operator_pb_role_paths,
      local.irsa_operator_pb_user_paths,
      local.irsa_operator_pb_role_prefixes,
      local.irsa_operator_pb_user_prefixes,
    )
  }
}
