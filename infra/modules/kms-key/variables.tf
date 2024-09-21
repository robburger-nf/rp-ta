###########
# Variables
###########
# Shared
variable "tags" {
  description = "A map of additional tags to add to all resources."
  type        = map(string)
  default     = {}
}

# Alias
variable "alias" {
  description = "The display name of the alias."
  type        = string
}

# KMS
variable "enable_key_rotation" {
  description = "Specifies whether automatic annual key rotation is enabled."
  type        = bool
  default     = true
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days."
  type        = number
  default     = 30

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "The deletion_window_in_days must be a value between 7 and 30."
  }
}

variable "description" {
  description = "The description of the key as viewed in AWS console."
  type        = string
}

variable "is_enabled" {
  description = "Specifies whether the key is enabled."
  type        = bool
  default     = true
}

variable "key_usage" {
  description = "Specifies the intended use of the key."
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "policy" {
  description = "A valid policy JSON document to manage key access that merges and/or overrides the default policy. WARNING: KMS key policies are explicit. See [Using Key Policies in AWS KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html)."
  type        = string
  default     = "{}"
}
