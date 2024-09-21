###########
# Providers
###########
# AWS
provider "aws" {
  region = "eu-west-2"
}

# AWS - Core - Security
provider "aws" {
  alias = "security"

  region = "eu-west-2"

  assume_role {
    role_arn = "arn:aws:iam::${module.account_security.id}:role/RootBillingCrossAccountAssumeAdmin"
  }
}
