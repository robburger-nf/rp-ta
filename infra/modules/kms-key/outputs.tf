#########
# Outputs
#########
output "arn" {
  description = "The ARN of the key."
  value       = aws_kms_key.this.arn
}

output "key_alias" {
  description = "The alias display name of the key."
  value       = aws_kms_alias.this.name
}

output "key_id" {
  description = "The globally unique identifier of the key."
  value       = aws_kms_key.this.key_id
}
