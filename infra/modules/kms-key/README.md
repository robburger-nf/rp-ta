# Terraform Module - KMS Key

Terraform module that creates an AWS KMS key and alias

## Usage

```hcl
module "kms_key_NAME" {
  source  = "./modules/kms-key"

  alias       = "s3"
  description = "Used to encrypt objects in S3 buckets"

  tags = local.shared_tags
}
```

## Warning

KMS keys don't behave like other AWS resources. Access to CMK's (Customer Managed Keys) is granted **only** through policies attached directly to the key. e.g.: The `root` AWS user does not implicitly have access to the key - it must be granted access via the key policy. In other words, if not set up correctly, you run the risk of the CMK becoming unmanageable!

Before overriding the default key `policy` variable in this module, ensure you are familiar and have a good understanding of [KMS CMK Policies](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html).

## Adding IAM Statements

This module allows for an IAM policy to be provided in a `var.policy` variable. These `statement`s will be merged with the default policy created by the module, but if a `statement` with the same `sid` is provided, it will override the default. (See the [Example of Merging Override Documents](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#example-of-merging-override-documents) documentation for more details.)

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
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this_combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | The display name of the alias. | `string` | n/a | yes |
| <a name="input_deletion_window_in_days"></a> [deletion\_window\_in\_days](#input\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. | `number` | `30` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the key as viewed in AWS console. | `string` | n/a | yes |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether automatic annual key rotation is enabled. | `bool` | `true` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Specifies whether the key is enabled. | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | A valid policy JSON document to manage key access that merges and/or overrides the default policy. WARNING: KMS key policies are explicit. See [Using Key Policies in AWS KMS](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html). | `string` | `"{}"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of additional tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the key. |
| <a name="output_key_alias"></a> [key\_alias](#output\_key\_alias) | The alias display name of the key. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | The globally unique identifier of the key. |
<!-- END_TF_DOCS -->
