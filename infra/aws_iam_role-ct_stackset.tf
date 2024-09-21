# See: https://docs.aws.amazon.com/controltower/latest/userguide/access-control-managing-permissions.html#AWSControlTowerStackSetRole

######
# Data
######
data "aws_iam_policy_document" "assume_role_stackset_cloudformation" {
  statement {
    sid = "AllowAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudformation.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "controltower_stackset_inline" {
  statement {
    sid = "AllowAssumeRole"

    actions = [
      "arn:aws:iam::*:role/AWSControlTowerExecution",
    ]

    resources = [
      "*",
    ]
  }
}

#####################
# Resources & Modules
#####################
resource "aws_iam_role" "controltower_stackset" {
  name               = "AWSControlTowerStackSetRole"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_stackset_cloudformation.json

  tags = merge(
    {
      Name                 = "AWSControlTowerStackSetRole"
      "root:iam-role:path" = "/service-role/"
    },
    local.shared_tags,
  )
}

resource "aws_iam_role_policy" "controltower_stackset_inline" {
  name   = "AWSControlTowerAdminPolicy"
  role   = aws_iam_role.controltower_stackset.name
  policy = data.aws_iam_policy_document.controltower_stackset_inline.json
}
