/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

variable "role_name" {
  description = "The name of the role. If omitted, role_prefix is used."
  default     = ""
  type        = string

  validation {
    condition     = length(var.role_name) <= 64
    error_message = "The role_name, when informed, cannot be longer than 64 characters."
  }
}

variable "role_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Ignored when role_name is informed."
  default     = "codeway-"
  type        = string

  validation {
    condition     = length(var.role_prefix) <= 32
    error_message = "The role_prefix cannot be longer than 32 characters."
  }
}

# TODO: Review the role/policy path standard.
variable "role_path" {
  description = "IAM role path."
  default     = "/codeway/"
  type        = string
}

# TODO: Review the role/policy path standard.
variable "policy_path" {
  description = "IAM policy path."
  default     = "/codeway/"
  type        = string
}

variable "policy_name_prefix" {
  description = "Prefix used to further restrict the services managed by the policies."
  default     = "codeway-"
  type        = string
}

variable "region" {
  description = "AWS Region for the IAM Permissions."
  default     = "*"
  type        = string
}

variable "codeway_projects" {
  description = "List of Codeway projects and library group to register the role arn and external Id."
  default     = []
  type = list(
    object({
      name            = string
      variable_group  = string
      variable_prefix = string
    })
  )
}

variable "remote_state_bucket_suffix" {
  description = "The suffix of the terraform remote state S3 bucket."
  default     = "terraform-remote-state"
  type        = string
}

variable "remote_state_dynamodb_suffix" {
  description = "The suffix of the terraform remote state DynamoSB lock table."
  default     = "terraform_state_locks"
  type        = string
}

variable "attach_acm_policy" {
  description = "Attach the ACM Policy."
  default     = false
  type        = bool
}

variable "attach_amp_policy" {
  description = "Attach the AMP Policy."
  default     = false
  type        = bool
}

variable "attach_asg_policy" {
  description = "Attach the ASG Policy."
  default     = false
  type        = bool
}

variable "attach_aws_mq_policy" {
  description = "Attach the Amazon MQ Policy."
  default     = false
  type        = bool
}

variable "attach_bastion_policy" {
  description = "Attach the Bastion Policy."
  default     = false
  type        = bool
}

variable "attach_cloudinit_policy" {
  description = "Attach the cloud-init Policy."
  default     = false
  type        = bool
}

variable "attach_cloudwatch_policy" {
  description = "Attach the Cloudwatch Policy."
  default     = false
  type        = bool
}

variable "attach_cloudfront_policy" {
  description = "Attach the Cloudfront Policy."
  default     = false
  type        = bool
}

variable "attach_cognito_policy" {
  description = "Attach the AWS Cognito Policy."
  default     = false
  type        = bool
}

variable "attach_dynamodb_policy" {
  description = "Attach the AWS Dynamodb Policy."
  default     = false
  type        = bool
}

variable "attach_ecr_policy" {
  description = "Attach the ECR Policy."
  default     = false
  type        = bool
}

variable "attach_ecs_policy" {
  description = "Attach the ECS Policy."
  default     = false
  type        = bool
}

variable "attach_efs_policy" {
  description = "Attach the EFS Policy."
  default     = false
  type        = bool
}

variable "attach_eks_policy" {
  description = "Attach the EKS Policy."
  default     = false
  type        = bool
}

variable "attach_elasticache_policy" {
  description = "Attach the Elasticache Policy."
  default     = false
  type        = bool
}

variable "attach_elasticsearch_policy" {
  description = "Attach the Elasticsearch Policy."
  default     = false
  type        = bool
}

variable "attach_iam_policy" {
  description = "Attach the IAM Policy."
  default     = false
  type        = bool
}

variable "attach_kinesis_policy" {
  description = "Attach the Kinesis Policy."
  default     = false
  type        = bool
}

variable "attach_kms_policy" {
  description = "Attach the KMS Policy."
  default     = false
  type        = bool
}

variable "attach_lambda_policy" {
  description = "Attach the ACM Policy."
  default     = false
  type        = bool
}

variable "attach_load_balancer_policy" {
  description = "Attach the Load Balancer Policy."
  default     = false
  type        = bool
}

variable "attach_mongodb_policy" {
  description = "Attach the Mongodb Atlas Policy."
  default     = false
  type        = bool
}

variable "attach_msk_policy" {
  description = "Attach the MSK Policy."
  default     = false
  type        = bool
}

variable "attach_neptune_policy" {
  description = "Attach the Neptune Policy."
  default     = false
  type        = bool
}

variable "attach_rds_policy" {
  description = "Attach the RDS Policy."
  default     = false
  type        = bool
}

variable "attach_route53_policy" {
  description = "Attach the Route53 Policy."
  default     = false
  type        = bool
}

variable "attach_s3_policy" {
  description = "Attach the S3 Policy."
  default     = false
  type        = bool
}

variable "attach_secrets_policy" {
  description = "Attach the Secrets Manager Policy."
  default     = false
  type        = bool
}

variable "attach_ses_policy" {
  description = "Attach the ses Policy."
  default     = false
  type        = bool
}

variable "attach_sns_sqs_policy" {
  description = "Attach the SNS/SQS Policy."
  default     = false
  type        = bool
}

variable "attach_ssm_policy" {
  description = "Attach the Session Manager Policy."
  default     = false
  type        = bool
}

variable "attach_vpc_policy" {
  description = "Attach the VPC Policy."
  default     = false
  type        = bool
}

variable "attach_waf_policy" {
  description = "Attach the WAF Policy."
  default     = false
  type        = bool
}

variable "additional_policy_arns" {
  description = "List of additional policy ARNs to attach in the role."
  default     = []
  type        = list(string)
}

variable "inline_policy" {
  description = "Custom policy to attach in the role as inline policy."
  default     = ""
  type        = string
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  default     = null
  type        = string
}

variable "max_session_duration" {
  description = " The maximum session duration (in seconds) that you want to set for the specified role."
  default     = 3600
  type        = number
}

variable "tags" {
  description = "A map of tags to add into all resources."
  default     = {}
  type        = map(string)
}
