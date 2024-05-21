/*
 * (C) Copyright 2019-2023 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

output "role_arn" {
  description = "IAM role ARN."
  value       = module.role.role_arn
}

output "role_id" {
  description = "IAM role ID."
  value       = module.role.role_id
}

output "role_name" {
  description = "IAM role name."
  value       = module.role.role_name
}
