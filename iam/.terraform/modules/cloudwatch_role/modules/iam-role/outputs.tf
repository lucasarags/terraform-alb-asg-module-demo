/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

output "role_arn" {
  description = "IAM role ARN."
  value       = aws_iam_role.role.arn
}

output "role_id" {
  description = "IAM role ID."
  value       = aws_iam_role.role.id
}

output "role_name" {
  description = "IAM role name."
  value       = aws_iam_role.role.name
}

output "instance_profile_arn" {
  description = "IAM instance profile ARN."
  value       = var.create_instance_profile ? aws_iam_instance_profile.profile[0].arn : ""
}

output "instance_profile_id" {
  description = "IAM instance profile ID."
  value       = var.create_instance_profile ? aws_iam_instance_profile.profile[0].id : ""
}

output "instance_profile_name" {
  description = "IAM instance profile name."
  value       = var.create_instance_profile ? aws_iam_instance_profile.profile[0].name : ""
}
