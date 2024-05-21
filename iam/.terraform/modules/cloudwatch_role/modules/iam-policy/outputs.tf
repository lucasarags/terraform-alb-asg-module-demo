/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

output "policy_arn" {
  description = "IAM policy ARN."
  value       = aws_iam_policy.policy.arn
}

output "policy_id" {
  description = "IAM policy ID."
  value       = aws_iam_policy.policy.id
}

output "policy_name" {
  description = "IAM policy name."
  value       = aws_iam_policy.policy.name
}
