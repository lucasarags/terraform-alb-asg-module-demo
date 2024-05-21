# Codeway Role Module

This folder contains a [Terraform](https://www.terraform.io/) that creates an IAM Role with a trust relationship established to the Codeway agent role. The role ARN and external ID are registered as secret variables in one or more Codeway projects.

## Personal Access Token

This module expects to find the ADO Personal Access Token in the `ADO_TOKEN` environment variable.

The following scope is required:

| Name | Description |
|------|-------------|
| vso.variablegroups_manage | Grants the ability to read, create and manage variablegroups |

## How to use this module?

This folder defines a [Terraform module](https://www.terraform.io/docs/modules/usage.html), which you can use in your code by adding a module configuration and setting its source parameter to URL of this folder:

```hcl
module "codeway_role" {
  # Check releases for updates in this module
  source = "github.azc.ext.hp.com/runway/terraform-aws-iam//modules/create-codeway-role?ref=v1.0.0"

  role_name        = "s3_provisioner"
  policy_arns      = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]

  codeway_projects = [{
      name            = "RunWay"
      variable_group  = "Defaults"
      variable_prefix = "s3"
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
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_role"></a> [role](#module\_role) | ../iam-role | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.register](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.external_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_roles_arns"></a> [assume\_roles\_arns](#input\_assume\_roles\_arns) | List of ARNs that can assume this role. | `list(string)` | <pre>[<br>  "arn:aws:iam::739081841199:role/codeway-agent-pools-agent-ec2",<br>  "arn:aws:iam::739081841199:role/codeway-agent-pools-dev-agent-ec2"<br>]</pre> | no |
| <a name="input_codeway_projects"></a> [codeway\_projects](#input\_codeway\_projects) | List of Codeway projects and variable group to register the role arn and external Id. | <pre>list(<br>    object({<br>      name            = string<br>      variable_group  = string<br>      variable_prefix = string<br>    })<br>  )</pre> | `[]` | no |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | Custom policy to attach in the role as inline policy. | `string` | `""` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. | `number` | `3600` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of policy ARNs to attach in the role. | `list(string)` | `[]` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the role. If omitted, role\_prefix is used. | `string` | `""` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | IAM role path. | `string` | `"/codeway/"` | no |
| <a name="input_role_prefix"></a> [role\_prefix](#input\_role\_prefix) | Creates a unique name beginning with the specified prefix. Ignored when role\_name is informed. | `string` | `"codeway-"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add into all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM role ARN. |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | IAM role ID. |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | IAM role name. |
<!-- END_TF_DOCS -->
