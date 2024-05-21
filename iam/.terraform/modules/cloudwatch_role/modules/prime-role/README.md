# Create Prime Role Module

This folder contains a [Terraform](https://www.terraform.io/) that creates an IAM Role with a trust relationship established to the Codeway Agent role. The role ARN and external ID are also registered as secret variables in one or more Codeway projects. 

This module extends the `create-codeway-role` module and creates what we conventioned to call the `prime-role`. An IAM role with the required policies to create other IAM entities.

## How to use this module?

See https://github.azc.ext.hp.com/runway/aws-account-bootstrap


## Permissions Boundaries

Default behavior is to not attach permissions boundaries to the prime role, however this behaviour is going to be reviewed in the future. 
You can enable the use of permissions boundaries with the `set_permissions_boundary` input variable.

Once you do it, three new policies are going to be created:
- RunwayPrimePermissionsBoundary
- RunwayProvisioningPermissionsBoundary
- RunwayRuntimePermissionsBoundary

The first, is attached to the prime role, enforcing the following behaviours:
- The prime role cannot be used to provision other resources than IAM roles.
- The prime role cannot modify or remove its permissions boundary.
- The prime role can only create new roles/users if attaching one of the three permissions boundaries listed above.
- The prime role can only delete roles/users with white-listed paths and prefixes.
- Provisioning roles cannot modify or remove the prime role.
- Provisioning roles cannot modify or remove its permissions boundary.
- Provisioning roles can only create new roles/users if attaching the RunwayRuntimePermissionsBoundary permissions boundary.
- Provisioning roles can only delete roles/users with white-listed paths and prefixes.
- Runtime roles cannot create, modify or remove IAM entities.

Use the following variables to whitelist roles/users:
- `provisioning_permissions_boundary_paths` (default to `["/codeway/"]`)
- `provisioning_permissions_boundary_prefixes` (default to `[]`)
- `runtime_permissions_boundary_paths` (default to `["/runway/"]`)
- `runtime_permissions_boundary_prefixes` (default to `[]`)

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
| <a name="module_codeway_role"></a> [codeway\_role](#module\_codeway\_role) | ../codeway-role | n/a |
| <a name="module_irsa_operator_boundary"></a> [irsa\_operator\_boundary](#module\_irsa\_operator\_boundary) | ../iam-policy | n/a |
| <a name="module_prime_boundary"></a> [prime\_boundary](#module\_prime\_boundary) | ../iam-policy | n/a |
| <a name="module_provisioning_boundary"></a> [provisioning\_boundary](#module\_provisioning\_boundary) | ../iam-policy | n/a |
| <a name="module_runtime_boundary"></a> [runtime\_boundary](#module\_runtime\_boundary) | ../iam-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_account_alias.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_account_alias) | data source |
| [aws_iam_policy_document.inline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.irsa_operator_boundary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.prime_boundary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.provisioning_boundary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.runtime_boundary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_policy_arns"></a> [additional\_policy\_arns](#input\_additional\_policy\_arns) | List of additional policy ARNs to attach in the role. | `list(string)` | `[]` | no |
| <a name="input_codeway_project"></a> [codeway\_project](#input\_codeway\_project) | Name of the Codeway project. | `string` | n/a | yes |
| <a name="input_inline_policy"></a> [inline\_policy](#input\_inline\_policy) | Custom policy to attach in the role as inline policy. | `string` | `"{}"` | no |
| <a name="input_irsa_operator_permissions_boundary_name"></a> [irsa\_operator\_permissions\_boundary\_name](#input\_irsa\_operator\_permissions\_boundary\_name) | The name of IRSA operator roles' permissions boundary. | `string` | `"RunwayIRSAOperatorBoundary"` | no |
| <a name="input_irsa_operator_permissions_boundary_paths"></a> [irsa\_operator\_permissions\_boundary\_paths](#input\_irsa\_operator\_permissions\_boundary\_paths) | The list of IAM users/roles paths the IRSA operator permissions boundary grants delete/pass access. | `list(string)` | <pre>[<br>  "/runway/"<br>]</pre> | no |
| <a name="input_irsa_operator_permissions_boundary_prefixes"></a> [irsa\_operator\_permissions\_boundary\_prefixes](#input\_irsa\_operator\_permissions\_boundary\_prefixes) | The list of IAM users/roles prefixes the IRSA operator permissions boundary grants delete/pass access. | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. | `number` | `3600` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the prime-role. Required for DIME accounts. | `string` | `""` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | IAM policy path. | `string` | `"/codeway/"` | no |
| <a name="input_prime_permissions_boundary_name"></a> [prime\_permissions\_boundary\_name](#input\_prime\_permissions\_boundary\_name) | The name of prime role's permissions boundary. | `string` | `"RunwayPrimePermissionsBoundary"` | no |
| <a name="input_provisioning_permissions_boundary_name"></a> [provisioning\_permissions\_boundary\_name](#input\_provisioning\_permissions\_boundary\_name) | The name of provisioning-time roles' permissions boundary. | `string` | `"RunwayProvisioningPermissionsBoundary"` | no |
| <a name="input_provisioning_permissions_boundary_paths"></a> [provisioning\_permissions\_boundary\_paths](#input\_provisioning\_permissions\_boundary\_paths) | The list of IAM users/roles paths the provisioning permissions boundary grants delete/pass access. | `list(string)` | <pre>[<br>  "/codeway/"<br>]</pre> | no |
| <a name="input_provisioning_permissions_boundary_prefixes"></a> [provisioning\_permissions\_boundary\_prefixes](#input\_provisioning\_permissions\_boundary\_prefixes) | The list of IAM users/roles prefixes the provisioning permissions boundary grants delete/pass access. | `list(string)` | `[]` | no |
| <a name="input_remote_state_bucket_suffix"></a> [remote\_state\_bucket\_suffix](#input\_remote\_state\_bucket\_suffix) | The suffix of the terraform remote state S3 bucket. | `string` | `"prime-remote-state"` | no |
| <a name="input_remote_state_dynamodb_suffix"></a> [remote\_state\_dynamodb\_suffix](#input\_remote\_state\_dynamodb\_suffix) | The suffix of the terraform remote state DynamoSB lock table. | `string` | `"prime_state_locks"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the role. If omitted, role\_prefix is used. | `string` | `""` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | IAM role path. | `string` | `"/codeway/"` | no |
| <a name="input_role_prefix"></a> [role\_prefix](#input\_role\_prefix) | Creates a unique name beginning with the specified prefix. Ignored when role\_name is informed. | `string` | `"runway-prime-"` | no |
| <a name="input_runtime_permissions_boundary_name"></a> [runtime\_permissions\_boundary\_name](#input\_runtime\_permissions\_boundary\_name) | The name of runtime roles' permissions boundary. | `string` | `"RunwayRuntimePermissionsBoundary"` | no |
| <a name="input_runtime_permissions_boundary_paths"></a> [runtime\_permissions\_boundary\_paths](#input\_runtime\_permissions\_boundary\_paths) | The list of IAM users/roles paths the runtime permissions boundary grants delete/pass access. | `list(string)` | <pre>[<br>  "/runway/"<br>]</pre> | no |
| <a name="input_runtime_permissions_boundary_prefixes"></a> [runtime\_permissions\_boundary\_prefixes](#input\_runtime\_permissions\_boundary\_prefixes) | The list of IAM users/roles prefixes the runtime permissions boundary grants delete/pass access. | `list(string)` | `[]` | no |
| <a name="input_set_permissions_boundary"></a> [set\_permissions\_boundary](#input\_set\_permissions\_boundary) | Whether the prime role should have a permissions boundary or not. | `bool` | `false` | no |
| <a name="input_variable_prefix"></a> [variable\_prefix](#input\_variable\_prefix) | Prefix of the prime role in CodeWay ADO variable group. | `string` | `"prime"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_prime_boundary_arn"></a> [prime\_boundary\_arn](#output\_prime\_boundary\_arn) | IAM policy ARN for the prime role's permissions boundary. |
| <a name="output_provisioning_boundary_arn"></a> [provisioning\_boundary\_arn](#output\_provisioning\_boundary\_arn) | IAM policy ARN for provisioning-time roles' permissions boundary. |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM role ARN. |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | IAM role ID. |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | IAM role name. |
| <a name="output_runtime_boundary_arn"></a> [runtime\_boundary\_arn](#output\_runtime\_boundary\_arn) | IAM policy ARN for runtime roles' permissions boundary. |
<!-- END_TF_DOCS -->
