module "acm" {
  source = "git::https://github.azc.ext.hp.com/runway/terraform-aws-acm.git//resources/provisioning-policy"

  name_prefix   = var.policy_name_prefix
  policy_path   = var.policy_path
  role_path     = var.role_path
  create_policy = var.attach_acm_policy
}

resource "aws_iam_role_policy_attachment" "acm" {
  count = var.attach_acm_policy ? 1 : 0

  policy_arn = module.acm.policy_arn
  role       = module.codeway_role.role_name
}
