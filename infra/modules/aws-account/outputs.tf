#########
# Outputs
#########
output "arn" {
  description = "The ARN for this account."
  value       = aws_organizations_account.this.arn
}

output "id" {
  description = "The AWS account ID."
  value       = aws_organizations_account.this.id
}
