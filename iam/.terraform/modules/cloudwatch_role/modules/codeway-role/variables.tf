/*
 * (C) Copyright 2019-2020 HP Development Company, L.P.
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
  default     = "codeway-"
  type        = string

  validation {
    condition     = length(var.role_prefix) <= 32
    error_message = "The role_prefix cannot be longer than 32 characters."
  }
}

# TODO: Review the role/policy path standard.
variable "role_path" {
  description = "IAM role path."
  default     = "/codeway/"
  type        = string
}

variable "assume_roles_arns" {
  description = "List of ARNs that can assume this role."
  default = [
    "arn:aws:iam::739081841199:role/codeway-agent-pools-agent-ec2",
    "arn:aws:iam::739081841199:role/codeway-agent-pools-dev-agent-ec2"
  ]
  type = list(string)
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

# TODO: Discuss with Codeway team about the variable_prefix design. 
# If we keep it, we'll need to change the runway-live-infrastructure template.
variable "codeway_projects" {
  description = "List of Codeway projects and variable group to register the role arn and external Id."
  default     = []
  type = list(
    object({
      name            = string
      variable_group  = string
      variable_prefix = string
    })
  )
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
