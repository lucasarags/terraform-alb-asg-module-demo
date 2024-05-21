/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "GLOBALIAM"
    actions = [
      "iam:ListAccountAliases",
    ]
    resources = ["*"]
  }

  statement {
    sid = "IAM"
    actions = [
      "iam:Get*",
      "iam:List*",
      "iam:CreateRole",
      "iam:PassRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:Tag*",
      "iam:Untag*",
    ]
    resources = [
      "arn:aws:iam::${local.account_id}:role/*",
      "arn:aws:iam::${local.account_id}:policy/*",
    ]
  }

  statement {
    sid = "IAMInstanceProfile"
    actions = [
      "iam:Get*",
      "iam:List*",
      "iam:Tag*",
      "iam:Untag*",
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile"
    ]
    resources = [
      "arn:aws:iam::${local.account_id}:instance-profile/*",
    ]
  }
}


data "aws_iam_policy_document" "test" {
  source_policy_documents = [data.aws_iam_policy_document.policy.json]

  statement {
    sid = "IAMTest"
    actions = [
      "iam:Get*",
      "iam:List*",
      "iam:Create*",
      "iam:Delete*",
      "iam:Update*",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:PutRolePolicy",
      "iam:AttachUserPolicy",
      "iam:DetachUserPolicy",
      "iam:PutUserPolicy",
    ]
    resources = [
      "arn:aws:iam::${local.account_id}:user/*",
      "arn:aws:iam::${local.account_id}:role/*",
      "arn:aws:iam::${local.account_id}:policy/*",
      "arn:aws:iam::${local.account_id}:instance-profile/*",
    ]
  }
}
