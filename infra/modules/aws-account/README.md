# Terraform Module - Organization Account

Terraform module that creates an AWS Organization Account

## Usage

```hcl
module "account_NAME" {
  source = "./module_account"

  email_suffix = "account_name"
  name         = "Account Name"
  parent_id    = aws_organizations_organizational_unit.core.id

  tags = local.shared_tags
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_email_suffix"></a> [email\_suffix](#input\_email\_suffix) | The name to append to the email address. | `string` | n/a | yes |
| <a name="input_iam_user_access_to_billing"></a> [iam\_user\_access\_to\_billing](#input\_iam\_user\_access\_to\_billing) | If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information. | `string` | `"ALLOW"` | no |
| <a name="input_name"></a> [name](#input\_name) | A friendly name for the account. | `string` | n/a | yes |
| <a name="input_parent_id"></a> [parent\_id](#input\_parent\_id) | Parent Organizational Unit ID or Root ID for the account. | `string` | n/a | yes |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of an IAM role that Organizations automatically preconfigures in the new member account. The default role allows the billing account to assume AdministratorAccess permissions. | `string` | `"RootBillingCrossAccountAssumeAdmin"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value map of resource tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN for this account. |
| <a name="output_id"></a> [id](#output\_id) | The AWS account ID. |
<!-- END_TF_DOCS -->
