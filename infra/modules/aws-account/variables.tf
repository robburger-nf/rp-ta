###########
# Variables
###########
variable "email_suffix" {
  description = "The name to append to the email address."
  type        = string

  validation {
    condition     = length(var.email_suffix) <= 42
    error_message = "Email suffix can't be longer than 42 characters."
  }
}

variable "iam_user_access_to_billing" {
  description = "If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information."
  type        = string
  default     = "ALLOW"
}

variable "name" {
  description = "A friendly name for the account."
  type        = string
}

variable "parent_id" {
  description = "Parent Organizational Unit ID or Root ID for the account."
  type        = string
}

variable "role_name" {
  description = "The name of an IAM role that Organizations automatically preconfigures in the new member account. The default role allows the billing account to assume AdministratorAccess permissions."
  type        = string
  default     = "RootBillingCrossAccountAssumeAdmin"
}

variable "tags" {
  description = "Key-value map of resource tags."
  type        = map(string)
  default     = {}
}
