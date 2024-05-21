# IAM Policy Module

This folder contains a [Terraform](https://www.terraform.io/) module that creates an IAM policy.

## How to use this module?

This folder defines a [Terraform module](https://www.terraform.io/docs/modules/usage.html), which you can use in your code by adding a module configuration and setting its source parameter to URL of this folder:

```hcl
module "create_policy" {
  # Check releases for updates in this module
  source = "github.azc.ext.hp.com/runway/terraform-aws-iam//modules/iam-policy?ref=v1.0.0"

  policy_name     = "my_policy"
  policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | The description of the policy | `string` | `""` | no |
| <a name="input_policy_document"></a> [policy\_document](#input\_policy\_document) | The policy document. This is a JSON formatted string. | `string` | n/a | yes |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy. If omitted, policy\_prefix is used. | `string` | `""` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | IAM policy path. | `string` | `"/"` | no |
| <a name="input_policy_prefix"></a> [policy\_prefix](#input\_policy\_prefix) | Creates a unique name beginning with the specified prefix. Ignored when policy\_name is informed. | `string` | `"runway-"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | IAM policy ARN. |
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | IAM policy ID. |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | IAM policy name. |
<!-- END_TF_DOCS -->
