# AWS IAM Role Management

This folder contains a [Terraform](https://www.terraform.io/) module that enables managing an existing IAM Role (not provisioned by Terraform) with AWS Managed Policies and Custom Policies.

## How to use this module?

This folder defines a [Terraform module](https://www.terraform.io/docs/modules/usage.html), which you can use in your code by adding a module configuration and setting its source parameter to URL of this folder:

```hcl
module "read_only_role" {
  # Check releases for updates in this module
  source = "github.azc.ext.hp.com/runway/terraform-aws-iam//modules/attach-policy-to-role?ref=v1.0.0"

    role_name = "READ_ONLY"

    policy_arns = [
      "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
      "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess",
    ]

    inline_policy = <<EOF
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
| [aws_iam_policy.custom_policy_with_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.custom_policy_with_prefix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role_policy_attachment.custom_role_policy_attachment_with_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom_role_policy_attachment_with_prefix](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of policy to attach to IAM role. | `string` | `"Managed by Terraform"` | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | Custom policy to attach in the role as inline policy. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Specify policy name to add to role. | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of policy ARNs to attach in the role. | `list(string)` | `[]` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the IAM Role to Manage. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
