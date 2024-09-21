######
# Data
######
data "aws_iam_policy_document" "kms_logs" {
  statement {
    sid = "Enable CloudTrail Service Permissions"

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
    ]

    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com",
      ]
    }

    resources = ["*"]
  }

  statement {
    sid = "Enable Log Service Permissions"

    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]

    principals {
      type = "Service"
      identifiers = [
        "delivery.logs.amazonaws.com",
      ]
    }

    resources = ["*"]
  }
}

#####################
# Resources & Modules
#####################
module "kms_key_logs" {
  source = "./modules/kms-key"

  alias       = "logs"
  description = "Master key used for encrypting logs"

  policy = data.aws_iam_policy_document.kms_logs.json

  tags = local.shared_tags
}
