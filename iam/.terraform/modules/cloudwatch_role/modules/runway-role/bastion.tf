/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

module "bastion" {
  source = "git::https://github.azc.ext.hp.com/runway/terraform-aws-bastion.git//resources/provisioning-policy"

  name_prefix   = var.policy_name_prefix
  policy_path   = var.policy_path
  role_path     = var.role_path
  create_policy = var.attach_bastion_policy
}

resource "aws_iam_role_policy_attachment" "bastion" {
  count = var.attach_bastion_policy ? 1 : 0

  policy_arn = module.bastion.policy_arn
  role       = module.codeway_role.role_name
}
