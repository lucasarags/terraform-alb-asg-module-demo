[![Build Status](https://dev.azure.com/hpcodeway/RunWay/_apis/build/status/runway.terraform-aws-iam?branchName=master)](https://dev.azure.com/hpcodeway/RunWay/_build/latest?definitionId=1070&branchName=master)

# AWS IAM Terraform Module

Modules in Terraform are self-contained packages of Terraform configurations that are managed as a group. Modules are used to create reusable components in Terraform as well as for basic code organization. Please review the Terraform documentation to become familiar with Modules: https://www.terraform.io/docs/modules/usage.html

This repo contains the following folder structure:

* [modules](./modules) contain several standalone, reusable, production-grade modules.
* [examples](./examples) contain examples that combine the modules in the `modules` folder to deploy real infrastructure.
* [test](./test) contain integration tests for the modules and examples.

## Requirements

1. Install [Terraform](https://www.terraform.io/downloads.html).
1. For scripting requirements, please use [Python3](https://www.python.org/downloads/).
1. For integration tests, please refer to the test requirements documented at [test/README.md](/test/README.md).

### Supported Operating Systems:

- [Linux](https://www.linux.org/)
- [Windows](https://www.microsoft.com/en-us/windows)

## Modules

For additional parameters you can use to customize each module, please read the `README.md` inside the module and check out the `examples/` folder for working sample code.

* [iam-role](./modules/iam-role/README.md) creates an AWS IAM role and attaches inline or managed policies to it.
* [service-linked-role](./modules/iam-service-linked-role/README.md) creates an AWS IAM service-linked role.
* [attach-policy-to-role](./modules/attach-policy-to-role/README.md) attaches a policy to an existing role not managed by terraform.
* [iam-policy](./modules/iam-policy/README.md) creates an AWS IAM managed policy.
* [prime-role](./modules/prime-role/README.md) creates an AWS IAM role with the right set of policies to manage IAM entities via CodeWay pipelines.
* [codeway-role](./modules/codeway-role/README.md) creates an AWS IAM role ready to integrate with CodeWay pipelines.
* [runway-role](./modules/runway-role/README.md) creates an AWS IAM role with the right set of policies to use RunWay modules via CodeWay pipelines.

## Issues

### Bugs

If you have found a bug please follow the instructions below:

- Spend a small amount of time giving due diligence to the issue tracker. Your issue might be a duplicate.
- Open a [new issue](../../issues/new).
- Inform what module version you are using.
- Paste in the issue the `terraform.tfvars` that you are using.
- Paste in the issue the `terraform plan` and `terraform apply` output.
- Remember, users might be searching for your issue in the future, so please give it a meaningful title to helps others.

### Features

If you have an idea for a new feature follow the steps below.

- Open a [new issue](../../issues/new).
- Remember, users might be searching for your issue in the future, so please give it a meaningful title to helps others.
- Clearly define the use case, using concrete examples.
- If you would like to include a technical design for your feature please include it in the issue.
- Feel free to code it yourself. Open up a pull request and happy coding.

## Contributing

Pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributors' Guide](https://pages.github.azc.ext.hp.com/runway/community/contribute/).
