/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

output "role_arn" {
  description = "IAM role ARN."
  value       = module.codeway_role.role_arn
}

output "role_id" {
  description = "IAM role ID."
  value       = module.codeway_role.role_id
}

output "role_name" {
  description = "IAM role name."
  value       = module.codeway_role.role_name
}

output "prime_boundary_arn" {
  description = "IAM policy ARN for the prime role's permissions boundary."
  value       = var.set_permissions_boundary ? module.prime_boundary[0].policy_arn : ""
}

output "provisioning_boundary_arn" {
  description = "IAM policy ARN for provisioning-time roles' permissions boundary."
  value       = var.set_permissions_boundary ? module.provisioning_boundary[0].policy_arn : ""
}

output "runtime_boundary_arn" {
  description = "IAM policy ARN for runtime roles' permissions boundary."
  value       = var.set_permissions_boundary ? module.runtime_boundary[0].policy_arn : ""
}
