######
# Data
######
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this_default" {
  statement {
    sid = "Enable root User Permissions"

    actions = ["kms:*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = ["*"]
  }

  statement {
    sid = "Enable Administrative Role Permissions"

    actions = [
      "kms:CancelKeyDeletion",
      "kms:Create*",
      "kms:Delete*",
      "kms:Describe*",
      "kms:Disable*",
      "kms:Enable*",
      "kms:Get*",
      "kms:List*",
      "kms:Put*",
      "kms:Revoke*",
      "kms:ScheduleKeyDeletion",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:Update*",
    ]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/provisioner/RootTerraformAdmin",
      ]
    }

    resources = ["*"]
  }

  statement {
    sid = "Enable Usage Role Permissions"

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalTag/root:iam-user:path"

      values = [
        "/human/",
        "/provisioner/",
      ]
    }
  }

  statement {
    sid = "Enable Grant Role Permissions"

    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalTag/root:iam-user:path"

      values = [
        "/human/",
        "/provisioner/",
      ]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"

      values = [
        true,
      ]
    }
  }
}

data "aws_iam_policy_document" "this_combined" {
  override_policy_documents = [
    data.aws_iam_policy_document.this_default.json,
    var.policy,
  ]
}

#####################
# Resources & Modules
#####################
resource "aws_kms_key" "this" {
  description             = var.description
  key_usage               = var.key_usage
  policy                  = data.aws_iam_policy_document.this_combined.json
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled              = var.is_enabled
  enable_key_rotation     = var.enable_key_rotation

  tags = var.tags
}

resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias}"
  target_key_id = aws_kms_key.this.key_id
}
