/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

variable "role_name" {
  description = "Name of the IAM Role to Manage."
  type        = string
}

variable "inline_policy" {
  description = "Custom policy to attach in the role as inline policy."
  default     = ""
  type        = string

  validation {
    condition     = length(replace(var.inline_policy, "/\\s+/", "")) <= 10240
    error_message = "The inline_policy cannot be longer than 10240 characters."
  }
}

variable "policy_arns" {
  description = "List of policy ARNs to attach in the role."
  default     = []
  type        = list(string)

  validation {
    condition     = length(var.policy_arns) <= 10
    error_message = "The policy_arns list cannot contain more than 10 policies."
  }
}

variable "name" {
  description = "Specify policy name to add to role."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of policy to attach to IAM role."
  type        = string
  default     = "Managed by Terraform"
}
