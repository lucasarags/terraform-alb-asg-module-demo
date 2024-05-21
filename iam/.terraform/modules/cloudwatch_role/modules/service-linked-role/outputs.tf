output "role_arn" {
  description = "IAM role ARN."
  value       = aws_iam_service_linked_role.service_linked_role.arn
}

output "role_id" {
  description = "IAM role ID."
  value       = aws_iam_service_linked_role.service_linked_role.id
}
