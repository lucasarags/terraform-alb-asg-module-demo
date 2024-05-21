/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

provider "aws" {
  region = var.region
}

module "role" {
  source = "../../modules/iam-role"

  role_name               = var.role_name
  role_prefix             = var.role_prefix
  role_path               = var.role_path
  assume_role_policy      = var.assume_role_policy
  create_instance_profile = var.create_instance_profile

  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
  ]
}
