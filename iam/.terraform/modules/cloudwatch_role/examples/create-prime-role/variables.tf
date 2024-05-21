/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

variable "region" {
  default = "us-west-2"
}

variable "role_name" {
  default = "prime-role"
}

variable "role_path" {
  default = "/runway/"
}

variable "codeway_project" {
  default = "RunWay"
}

variable "variable_prefix" {
  default = "prime"
}

variable "set_permissions_boundary" {
  default = false
}

variable "prime_permissions_boundary_name" {
  default = "RunwayPrimePermissionsBoundaryTest"
}

variable "provisioning_permissions_boundary_name" {
  default = "RunwayProvisioningPermissionsBoundaryTest"
}

variable "runtime_permissions_boundary_name" {
  default = "RunwayRuntimePermissionsBoundaryTest"
}
