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

module "pipeline_role" {
  source = "../../modules/runway-role"

  role_name                   = var.role_name
  role_path                   = var.role_path
  codeway_projects            = var.codeway_projects1
  attach_asg_policy           = true
  attach_cloudwatch_policy    = true
  attach_ecs_policy           = true
  attach_ecr_policy           = true
  attach_eks_policy           = true
  attach_rds_policy           = true
  attach_load_balancer_policy = true
  attach_secrets_policy       = true
  attach_sns_sqs_policy       = true
  attach_vpc_policy           = true
  inline_policy               = <<JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyAll",
      "Effect": "Deny",
      "Action": [
        "*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
JSON
}

# IAM Roles have a limit of 10 managed policies
# Every time we reach this limit, we add an additional role
# The intent here is to ensure we can validate all Runway provisioning policies
# In a real scenario, you'll probably won't reach this limit
module "pipeline_role2" {
  source = "../../modules/runway-role"

  role_name                   = format("%s-2", var.role_name)
  role_path                   = var.role_path
  codeway_projects            = var.codeway_projects2
  attach_elasticache_policy   = true
  attach_elasticsearch_policy = true
  attach_ssm_policy           = true
  attach_kms_policy           = true
  attach_neptune_policy       = true
  attach_bastion_policy       = true
  attach_kinesis_policy       = true
  attach_msk_policy           = true
  attach_mongodb_policy       = true
}
