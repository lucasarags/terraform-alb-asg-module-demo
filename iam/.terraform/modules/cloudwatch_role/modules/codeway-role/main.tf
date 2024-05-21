/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

module "role" {
  source = "../iam-role"

  role_description     = "Provisioning role used by Codeway automation"
  role_name            = var.role_name
  role_prefix          = var.role_prefix
  role_path            = var.role_path
  inline_policy        = var.inline_policy
  max_session_duration = var.max_session_duration
  policy_arns          = var.policy_arns
  permissions_boundary = var.permissions_boundary
  tags                 = var.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
}

resource "random_password" "external_id" {
  length           = 10
  override_special = "=,.@:-"
}

resource "null_resource" "register" {
  count = length(var.codeway_projects)

  triggers = {
    name            = var.codeway_projects[count.index].name
    variable_group  = var.codeway_projects[count.index].variable_group
    variable_prefix = var.codeway_projects[count.index].variable_prefix
    role_arn        = module.role.role_arn
    external_id     = random_password.external_id.result
  }

  provisioner "local-exec" {
    on_failure  = fail
    working_dir = format("%s/scripts", path.module)

    # Directories start with "C:..." on Windows; All other OSs use "/" for root.
    interpreter = substr(pathexpand("~"), 0, 1) == "/" ? [] : ["PowerShell", "-Command"]
    # local variables aren't supported in provisioners in Terraform v0.13.x

    command = format("python3 register.py \"%s\" \"%s\" \"%s\" \"%s\" \"%s\"",
      self.triggers.name,
      self.triggers.variable_group,
      self.triggers.variable_prefix,
      self.triggers.role_arn,
      self.triggers.external_id,
    )
  }

  provisioner "local-exec" {
    when        = destroy
    on_failure  = fail
    working_dir = format("%s/scripts", path.module)

    # Directories start with "C:..." on Windows; All other OSs use "/" for root.
    interpreter = substr(pathexpand("~"), 0, 1) == "/" ? [] : ["PowerShell", "-Command"]
    # local variables aren't supported in provisioners in Terraform v0.13.x

    command = format("python3 unregister.py \"%s\" \"%s\" \"%s\"",
      self.triggers.name,
      self.triggers.variable_group,
      self.triggers.variable_prefix,
    )
  }
}
