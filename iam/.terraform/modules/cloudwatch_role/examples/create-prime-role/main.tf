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

module "prime_role" {
  source = "../../modules/prime-role"

  role_name       = var.role_name
  role_path       = var.role_path
  codeway_project = var.codeway_project
  variable_prefix = var.variable_prefix

  set_permissions_boundary               = var.set_permissions_boundary
  prime_permissions_boundary_name        = var.prime_permissions_boundary_name
  provisioning_permissions_boundary_name = var.provisioning_permissions_boundary_name
  runtime_permissions_boundary_name      = var.runtime_permissions_boundary_name
}
