# Runway Role Module

This folder contains a [Terraform](https://www.terraform.io/) module that extends the `codeway-role` module providing a set of flags for enabling the provisioning of each Runway module via Codeway pipelines.

## How to use this module?

This folder defines a [Terraform module](https://www.terraform.io/docs/modules/usage.html), which you can use in your code by adding a module configuration and setting its source parameter to URL of this folder:

```hcl
module "runway_role" {
  # Check releases for updates in this module
  source = "github.azc.ext.hp.com/runway/terraform-aws-iam//modules/runway-role?ref=v1.0.0"

  role_name             = "runway_provisioner"
  attach_acm_policy     = true
  attach_asg_policy     = true
  attach_ecr_policy     = true
  attach_ecs_policy     = true
  attach_eks_policy     = true
  attach_rds_policy     = true
  attach_secrets_policy = true
  attach_vpc_policy     = true

  codeway_projects = [{
      name            = "RunWay"
      variable_group  = "Defaults"
      variable_prefix = "runway"
  }]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | git::https://github.azc.ext.hp.com/runway/terraform-aws-acm.git//resources/provisioning-policy | n/a |
| <a name="module_amp"></a> [amp](#module\_amp) | git::https://github.azc.ext.hp.com/runway-incubator/terraform-aws-managed-prometheus.git//resources/provisioning-policy | n/a |
| <a name="module_asg"></a> [asg](#module\_asg) | git::https://github.azc.ext.hp.com/runway/terraform-aws-asg.git//resources/provisioning-policy | n/a |
| <a name="module_aws_mq"></a> [aws\_mq](#module\_aws\_mq) | git::https://github.azc.ext.hp.com/runway-incubator/terraform-aws-mq-broker.git//resources/provisioning-policy | n/a |
| <a name="module_bastion"></a> [bastion](#module\_bastion) | git::https://github.azc.ext.hp.com/runway/terraform-aws-bastion.git//resources/provisioning-policy | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | git::https://github.azc.ext.hp.com/runway/terraform-aws-cloudfront.git//resources/provisioning-policy | n/a |
| <a name="module_cloudinit"></a> [cloudinit](#module\_cloudinit) | git::https://github.azc.ext.hp.com/runway/terraform-aws-cloud-init.git//resources/provisioning-policy | n/a |
| <a name="module_cloudwatch"></a> [cloudwatch](#module\_cloudwatch) | git::https://github.azc.ext.hp.com/runway/terraform-aws-cloudwatch.git//resources/provisioning-policy | n/a |
| <a name="module_codeway_role"></a> [codeway\_role](#module\_codeway\_role) | ../codeway-role | n/a |
| <a name="module_cognito"></a> [cognito](#module\_cognito) | git::https://github.azc.ext.hp.com/runway/terraform-aws-cognito.git//resources/provisioning-policy | n/a |
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | git::https://github.azc.ext.hp.com/runway/terraform-aws-dynamodb.git//resources/provisioning-policy | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | git::https://github.azc.ext.hp.com/runway/terraform-aws-ecr.git//resources/provisioning-policy | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | git::https://github.azc.ext.hp.com/runway/terraform-aws-ecs.git//resources/provisioning-policy | n/a |
| <a name="module_efs"></a> [efs](#module\_efs) | git::https://github.azc.ext.hp.com/runway/terraform-aws-efs.git//resources/provisioning-policy | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | git::https://github.azc.ext.hp.com/runway/terraform-aws-eks.git//resources/provisioning-policy | n/a |
| <a name="module_elasticache"></a> [elasticache](#module\_elasticache) | git::https://github.azc.ext.hp.com/runway/terraform-aws-elasticache.git//resources/provisioning-policy | n/a |
| <a name="module_elasticsearch"></a> [elasticsearch](#module\_elasticsearch) | git::https://github.azc.ext.hp.com/runway/terraform-aws-elasticsearch.git//resources/provisioning-policy | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ../../resources/provisioning-policy | n/a |
| <a name="module_kinesis"></a> [kinesis](#module\_kinesis) | git::https://github.azc.ext.hp.com/runway/terraform-aws-kinesis.git//resources/provisioning-policy | n/a |
| <a name="module_kms"></a> [kms](#module\_kms) | git::https://github.azc.ext.hp.com/runway/terraform-aws-kms.git//resources/provisioning-policy | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | git::https://github.azc.ext.hp.com/runway/terraform-aws-lambda.git//resources/provisioning-policy | n/a |
| <a name="module_load_balancer"></a> [load\_balancer](#module\_load\_balancer) | git::https://github.azc.ext.hp.com/runway/terraform-aws-load-balancer.git//resources/provisioning-policy | n/a |
| <a name="module_mongodb"></a> [mongodb](#module\_mongodb) | git::https://github.azc.ext.hp.com/runway/terraform-mongodb-atlas.git//resources/provisioning-policy | n/a |
| <a name="module_msk"></a> [msk](#module\_msk) | git::https://github.azc.ext.hp.com/runway-incubator/terraform-aws-msk.git//resources/provisioning-policy | n/a |
| <a name="module_neptune"></a> [neptune](#module\_neptune) | git::https://github.azc.ext.hp.com/runway/terraform-aws-neptune.git//resources/provisioning-policy | n/a |
| <a name="module_rds"></a> [rds](#module\_rds) | git::https://github.azc.ext.hp.com/runway/terraform-aws-rds.git//resources/provisioning-policy | n/a |
| <a name="module_route53"></a> [route53](#module\_route53) | git::https://github.azc.ext.hp.com/runway/terraform-aws-route53.git//resources/provisioning-policy | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | git::https://github.azc.ext.hp.com/runway/terraform-aws-s3.git//resources/provisioning-policy | n/a |
| <a name="module_secrets_manager"></a> [secrets\_manager](#module\_secrets\_manager) | git::ssh://git@github.azc.ext.hp.com/runway/terraform-aws-secrets-manager.git//resources/provisioning-policy | n/a |
| <a name="module_ses"></a> [ses](#module\_ses) | git::https://github.azc.ext.hp.com/runway-incubator/terraform-aws-ses.git//resources/provisioning-policy | n/a |
| <a name="module_sns_sqs"></a> [sns\_sqs](#module\_sns\_sqs) | git::https://github.azc.ext.hp.com/runway/terraform-aws-sns-sqs.git//resources/provisioning-policy | n/a |
| <a name="module_ssm"></a> [ssm](#module\_ssm) | git::https://github.azc.ext.hp.com/runway/terraform-aws-session-manager.git//resources/provisioning-policy | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.azc.ext.hp.com/runway/terraform-aws-vpc.git//resources/provisioning-policy | n/a |
| <a name="module_waf"></a> [waf](#module\_waf) | git::https://github.azc.ext.hp.com/runway/terraform-aws-waf.git//resources/provisioning-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role_policy_attachment.acm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.aws_mq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudfront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudinit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.cognito](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.efs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.elasticache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.elasticsearch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.kinesis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.load_balancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.mongodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.neptune](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.route53](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.secrets_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ses](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sns_sqs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.waf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.inline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_policy_arns"></a> [additional\_policy\_arns](#input\_additional\_policy\_arns) | List of additional policy ARNs to attach in the role. | `list(string)` | `[]` | no |
| <a name="input_attach_acm_policy"></a> [attach\_acm\_policy](#input\_attach\_acm\_policy) | Attach the ACM Policy. | `bool` | `false` | no |
| <a name="input_attach_amp_policy"></a> [attach\_amp\_policy](#input\_attach\_amp\_policy) | Attach the AMP Policy. | `bool` | `false` | no |
| <a name="input_attach_asg_policy"></a> [attach\_asg\_policy](#input\_attach\_asg\_policy) | Attach the ASG Policy. | `bool` | `false` | no |
| <a name="input_attach_aws_mq_policy"></a> [attach\_aws\_mq\_policy](#input\_attach\_aws\_mq\_policy) | Attach the Amazon MQ Policy. | `bool` | `false` | no |
| <a name="input_attach_bastion_policy"></a> [attach\_bastion\_policy](#input\_attach\_bastion\_policy) | Attach the Bastion Policy. | `bool` | `false` | no |
| <a name="input_attach_cloudfront_policy"></a> [attach\_cloudfront\_policy](#input\_attach\_cloudfront\_policy) | Attach the Cloudfront Policy. | `bool` | `false` | no |
| <a name="input_attach_cloudinit_policy"></a> [attach\_cloudinit\_policy](#input\_attach\_cloudinit\_policy) | Attach the cloud-init Policy. | `bool` | `false` | no |
| <a name="input_attach_cloudwatch_policy"></a> [attach\_cloudwatch\_policy](#input\_attach\_cloudwatch\_policy) | Attach the Cloudwatch Policy. | `bool` | `false` | no |
| <a name="input_attach_cognito_policy"></a> [attach\_cognito\_policy](#input\_attach\_cognito\_policy) | Attach the AWS Cognito Policy. | `bool` | `false` | no |
| <a name="input_attach_dynamodb_policy"></a> [attach\_dynamodb\_policy](#input\_attach\_dynamodb\_policy) | Attach the AWS Dynamodb Policy. | `bool` | `false` | no |
| <a name="input_attach_ecr_policy"></a> [attach\_ecr\_policy](#input\_attach\_ecr\_policy) | Attach the ECR Policy. | `bool` | `false` | no |
| <a name="input_attach_ecs_policy"></a> [attach\_ecs\_policy](#input\_attach\_ecs\_policy) | Attach the ECS Policy. | `bool` | `false` | no |
| <a name="input_attach_efs_policy"></a> [attach\_efs\_policy](#input\_attach\_efs\_policy) | Attach the EFS Policy. | `bool` | `false` | no |
| <a name="input_attach_eks_policy"></a> [attach\_eks\_policy](#input\_attach\_eks\_policy) | Attach the EKS Policy. | `bool` | `false` | no |
| <a name="input_attach_elasticache_policy"></a> [attach\_elasticache\_policy](#input\_attach\_elasticache\_policy) | Attach the Elasticache Policy. | `bool` | `false` | no |
| <a name="input_attach_elasticsearch_policy"></a> [attach\_elasticsearch\_policy](#input\_attach\_elasticsearch\_policy) | Attach the Elasticsearch Policy. | `bool` | `false` | no |
| <a name="input_attach_iam_policy"></a> [attach\_iam\_policy](#input\_attach\_iam\_policy) | Attach the IAM Policy. | `bool` | `false` | no |
| <a name="input_attach_kinesis_policy"></a> [attach\_kinesis\_policy](#input\_attach\_kinesis\_policy) | Attach the Kinesis Policy. | `bool` | `false` | no |
| <a name="input_attach_kms_policy"></a> [attach\_kms\_policy](#input\_attach\_kms\_policy) | Attach the KMS Policy. | `bool` | `false` | no |
| <a name="input_attach_lambda_policy"></a> [attach\_lambda\_policy](#input\_attach\_lambda\_policy) | Attach the ACM Policy. | `bool` | `false` | no |
| <a name="input_attach_load_balancer_policy"></a> [attach\_load\_balancer\_policy](#input\_attach\_load\_balancer\_policy) | Attach the Load Balancer Policy. | `bool` | `false` | no |
| <a name="input_attach_mongodb_policy"></a> [attach\_mongodb\_policy](#input\_attach\_mongodb\_policy) | Attach the Mongodb Atlas Policy. | `bool` | `false` | no |
| <a name="input_attach_msk_policy"></a> [attach\_msk\_policy](#input\_attach\_msk\_policy) | Attach the MSK Policy. | `bool` | `false` | no |
| <a name="input_attach_neptune_policy"></a> [attach\_neptune\_policy](#input\_attach\_neptune\_policy) | Attach the Neptune Policy. | `bool` | `false` | no |
| <a name="input_attach_rds_policy"></a> [attach\_rds\_policy](#input\_attach\_rds\_policy) | Attach the RDS Policy. | `bool` | `false` | no |
| <a name="input_attach_route53_policy"></a> [attach\_route53\_policy](#input\_attach\_route53\_policy) | Attach the Route53 Policy. | `bool` | `false` | no |
| <a name="input_attach_s3_policy"></a> [attach\_s3\_policy](#input\_attach\_s3\_policy) | Attach the S3 Policy. | `bool` | `false` | no |
| <a name="input_attach_secrets_policy"></a> [attach\_secrets\_policy](#input\_attach\_secrets\_policy) | Attach the Secrets Manager Policy. | `bool` | `false` | no |
| <a name="input_attach_ses_policy"></a> [attach\_ses\_policy](#input\_attach\_ses\_policy) | Attach the ses Policy. | `bool` | `false` | no |
| <a name="input_attach_sns_sqs_policy"></a> [attach\_sns\_sqs\_policy](#input\_attach\_sns\_sqs\_policy) | Attach the SNS/SQS Policy. | `bool` | `false` | no |
| <a name="input_attach_ssm_policy"></a> [attach\_ssm\_policy](#input\_attach\_ssm\_policy) | Attach the Session Manager Policy. | `bool` | `false` | no |
| <a name="input_attach_vpc_policy"></a> [attach\_vpc\_policy](#input\_attach\_vpc\_policy) | Attach the VPC Policy. | `bool` | `false` | no |
| <a name="input_attach_waf_policy"></a> [attach\_waf\_policy](#input\_attach\_waf\_policy) | Attach the WAF Policy. | `bool` | `false` | no |
| <a name="input_codeway_projects"></a> [codeway\_projects](#input\_codeway\_projects) | List of Codeway projects and library group to register the role arn and external Id. | <pre>list(<br>    object({<br>      name            = string<br>      variable_group  = string<br>      variable_prefix = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | Custom policy to attach in the role as inline policy. | `string` | `""` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. | `number` | `3600` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| <a name="input_policy_name_prefix"></a> [policy\_name\_prefix](#input\_policy\_name\_prefix) | Prefix used to further restrict the services managed by the policies. | `string` | `"codeway-"` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | IAM policy path. | `string` | `"/codeway/"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region for the IAM Permissions. | `string` | `"*"` | no |
| <a name="input_remote_state_bucket_suffix"></a> [remote\_state\_bucket\_suffix](#input\_remote\_state\_bucket\_suffix) | The suffix of the terraform remote state S3 bucket. | `string` | `"terraform-remote-state"` | no |
| <a name="input_remote_state_dynamodb_suffix"></a> [remote\_state\_dynamodb\_suffix](#input\_remote\_state\_dynamodb\_suffix) | The suffix of the terraform remote state DynamoSB lock table. | `string` | `"terraform_state_locks"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the role. If omitted, role\_prefix is used. | `string` | `""` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | IAM role path. | `string` | `"/codeway/"` | no |
| <a name="input_role_prefix"></a> [role\_prefix](#input\_role\_prefix) | Creates a unique name beginning with the specified prefix. Ignored when role\_name is informed. | `string` | `"codeway-"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add into all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM role ARN |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | IAM role ID |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | IAM role name |
<!-- END_TF_DOCS -->
