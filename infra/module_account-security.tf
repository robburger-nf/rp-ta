#####################
# Resources & Modules
#####################
module "account_security" {
  source = "./modules/aws-account"

  email_suffix = "security"
  name         = "Root Security"
  parent_id    = aws_organizations_organizational_unit.core.id

  tags = local.shared_tags
}

resource "aws_iam_account_alias" "account_alias_security" {
  provider = aws.security

  account_alias = "root-security"
}
