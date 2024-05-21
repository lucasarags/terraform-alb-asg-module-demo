/*
 * (C) Copyright 2019-2023 HP Development Company, L.P.
 * Confidential computer software. Valid license from HP required for possession, use or copying.
 * Consistent with FAR 12.211 and 12.212, Commercial Computer Software,
 * Computer Software Documentation, and Technical Data for Commercial Items are licensed
 * to the U.S. Government under vendor's standard commercial license.
 */

variable "role_name" {
  description = "The name of the role. If omitted, role_prefix is used."
  default     = ""
  type        = string

  validation {
    condition     = length(var.role_name) <= 64
    error_message = "The role_name, when informed, cannot be longer than 64 characters."
  }
}

variable "role_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Ignored when role_name is informed."
  default     = "runway-"
  type        = string

  validation {
    condition     = length(var.role_prefix) <= 32
    error_message = "The role_prefix cannot be longer than 32 characters."
  }
}

variable "role_description" {
  description = "The description of the role."
  default     = ""
  type        = string
}

variable "role_path" {
  description = "IAM role path."
  default     = "/"
  type        = string
}

variable "create_instance_profile" {
  description = "Create an IAM instance profile associated to this role."
  default     = false
  type        = bool
}

variable "assume_role_policy" {
  description = "The policy that grants an entity permission to assume the role."
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = length(replace(var.assume_role_policy, "/\\s+/", "")) <= 2048
    error_message = "The assume_role_policy cannot be longer than 2048 characters."
  }
}

variable "assume_role_arns" {
  description = "List of ARNs that can assume this role."
  default     = []
  type        = list(string)
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

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  default     = null
  type        = string
}

variable "max_session_duration" {
  description = " The maximum session duration (in seconds) that you want to set for the specified role."
  default     = 3600
  type        = number
}

variable "tags" {
  description = "A map of tags to add into all resources."
  default     = {}
  type        = map(string)
}
