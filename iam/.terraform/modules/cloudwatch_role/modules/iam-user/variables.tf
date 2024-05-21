/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

variable "user_name" {
  description = "The name of the user"
  default     = ""
  type        = string
}

variable "user_path" {
  description = "IAM user path."
  default     = "/"
  type        = string
}

variable "inline_policy" {
  description = "Custom policy to attach in the user as inline policy."
  default     = ""
  type        = string

  validation {
    condition     = length(replace(var.inline_policy, "/\\s+/", "")) <= 10240
    error_message = "The inline_policy cannot be longer than 10240 characters."
  }
}

variable "policy_arns" {
  description = "List of policy ARNs to attach in the user."
  default     = []
  type        = list(string)

  validation {
    condition     = length(var.policy_arns) <= 10
    error_message = "The policy_arns list cannot contain more than 10 policies."
  }
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the user."
  default     = null
  type        = string
}

variable "tags" {
  description = "A map of tags to add into all resources."
  default     = {}
  type        = map(string)
}
