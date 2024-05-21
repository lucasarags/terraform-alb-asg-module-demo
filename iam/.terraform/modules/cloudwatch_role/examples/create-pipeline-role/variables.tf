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
  default = "myapp"
}

variable "role_path" {
  default = "/runway/"
}

variable "codeway_projects1" {
  default = [{
    name            = "RunWay"
    variable_group  = "Defaults"
    variable_prefix = "terratest"
  }]
  type = list(
    object({
      name            = string
      variable_group  = string
      variable_prefix = string
    })
  )
}

variable "codeway_projects2" {
  default = [{
    name            = "RunWay"
    variable_group  = "Defaults"
    variable_prefix = "terratest"
  }]
  type = list(
    object({
      name            = string
      variable_group  = string
      variable_prefix = string
    })
  )
}
