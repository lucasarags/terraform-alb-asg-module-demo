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
  default     = "runway-prime-"
  type        = string

  validation {
    condition     = length(var.role_prefix) <= 32
    error_message = "The role_prefix cannot be longer than 32 characters."
  }
}

variable "variable_prefix" {
  description = "Prefix of the prime role in CodeWay ADO variable group."
  default     = "prime"
  type        = string
}

variable "role_path" {
  description = "IAM role path."
  default     = "/codeway/"
  type        = string
}

variable "policy_path" {
  description = "IAM policy path."
  default     = "/codeway/"
  type        = string
}

variable "codeway_project" {
  description = "Name of the Codeway project."
  type        = string
}

variable "permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the prime-role. Required for DIME accounts."
  default     = ""
  type        = string
}

variable "set_permissions_boundary" {
  description = "Whether the prime role should have a permissions boundary or not."
  default     = false
  type        = bool
}

variable "prime_permissions_boundary_name" {
  description = "The name of prime role's permissions boundary."
  default     = "RunwayPrimePermissionsBoundary"
  type        = string

  validation {
    condition     = length(var.prime_permissions_boundary_name) <= 64
    error_message = "The prime_permissions_boundary_name cannot be longer than 64 characters."
  }
}

variable "provisioning_permissions_boundary_name" {
  description = "The name of provisioning-time roles' permissions boundary."
  default     = "RunwayProvisioningPermissionsBoundary"
  type        = string

  validation {
    condition     = length(var.provisioning_permissions_boundary_name) <= 64
    error_message = "The provisioning_permissions_boundary_name cannot be longer than 64 characters."
  }
}

variable "provisioning_permissions_boundary_paths" {
  description = "The list of IAM users/roles paths the provisioning permissions boundary grants delete/pass access."
  default     = ["/codeway/"]
  type        = list(string)
}

variable "provisioning_permissions_boundary_prefixes" {
  description = "The list of IAM users/roles prefixes the provisioning permissions boundary grants delete/pass access."
  default     = []
  type        = list(string)
}

variable "runtime_permissions_boundary_name" {
  description = "The name of runtime roles' permissions boundary."
  default     = "RunwayRuntimePermissionsBoundary"
  type        = string

  validation {
    condition     = length(var.runtime_permissions_boundary_name) <= 64
    error_message = "The runtime_permissions_boundary_name cannot be longer than 64 characters."
  }
}

variable "runtime_permissions_boundary_paths" {
  description = "The list of IAM users/roles paths the runtime permissions boundary grants delete/pass access."
  default     = ["/runway/"]
  type        = list(string)
}

variable "runtime_permissions_boundary_prefixes" {
  description = "The list of IAM users/roles prefixes the runtime permissions boundary grants delete/pass access."
  default     = []
  type        = list(string)
}

variable "irsa_operator_permissions_boundary_name" {
  description = "The name of IRSA operator roles' permissions boundary."
  default     = "RunwayIRSAOperatorBoundary"
  type        = string

  validation {
    condition     = length(var.irsa_operator_permissions_boundary_name) <= 64
    error_message = "The irsa_operator_permissions_boundary_name cannot be longer than 64 characters."
  }
}

variable "irsa_operator_permissions_boundary_paths" {
  description = "The list of IAM users/roles paths the IRSA operator permissions boundary grants delete/pass access."
  default     = ["/runway/"]
  type        = list(string)
}

variable "irsa_operator_permissions_boundary_prefixes" {
  description = "The list of IAM users/roles prefixes the IRSA operator permissions boundary grants delete/pass access."
  default     = []
  type        = list(string)
}

variable "remote_state_bucket_suffix" {
  description = "The suffix of the terraform remote state S3 bucket."
  default     = "prime-remote-state"
  type        = string
}

variable "remote_state_dynamodb_suffix" {
  description = "The suffix of the terraform remote state DynamoSB lock table."
  default     = "prime_state_locks"
  type        = string
}

variable "additional_policy_arns" {
  description = "List of additional policy ARNs to attach in the role."
  default     = []
  type        = list(string)
}

variable "inline_policy" {
  description = "Custom policy to attach in the role as inline policy."
  default     = "{}"
  type        = string

  validation {
    condition     = length(replace(var.inline_policy, "/\\s+/", "")) <= 10240
    error_message = "The inline_policy cannot be longer than 10240 characters."
  }
}

variable "max_session_duration" {
  description = " The maximum session duration (in seconds) that you want to set for the specified role."
  default     = 3600
  type        = number
}
