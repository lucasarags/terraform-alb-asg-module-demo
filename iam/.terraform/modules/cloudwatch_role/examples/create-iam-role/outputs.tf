/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

output "role_arn" {
  value = module.role.role_arn
}

output "role_id" {
  value = module.role.role_id
}

output "role_name" {
  value = module.role.role_name
}

output "instance_profile_arn" {
  value = module.role.instance_profile_arn
}

output "instance_profile_id" {
  value = module.role.instance_profile_id
}

output "instance_profile_name" {
  value = module.role.instance_profile_name
}
