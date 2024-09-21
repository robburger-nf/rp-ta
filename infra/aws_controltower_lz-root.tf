#####################
# Resources & Modules
#####################
resource "aws_controltower_landing_zone" "root" {
  manifest_json = jsonencode(
    {
      governedRegions = [
        "af-south-1",
        "eu-west-2",
        "us-east-1",
      ],
      organizationStructure = {
        security = {
          name = aws_organizations_organizational_unit.core.name
        },
        sandbox = {
          name = aws_organizations_organizational_unit.sandbox.name
        },
      },
      centralizedLogging = {
        accountId = module.account_security.id,
        enabled   = true,
        configurations = {
          loggingBucket = {
            retentionDays = 90
          },
          accessLoggingBucket = {
            retentionDays = 90
          },
          kmsKeyArn = module.kms_key_logs.arn,
        },
      },
      securityRoles = {
        accountId = module.account_security.id,
      },
      accessManagement = {
        enabled = true
      },
    }
  )
  version = "3.2"
}
