# See: https://docs.aws.amazon.com/controltower/latest/userguide/access-control-managing-permissions.html#AWSControlTowerCloudTrailRole

######
# Data
######
data "aws_iam_policy_document" "assume_role_cloudtrail_cloudtrail" {
  statement {
    sid = "AllowAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "controltower_cloudtrail_inline" {
  statement {
    sid = "AllowLogging"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:log-group:aws-controltower/CloudTrailLogs:*",
    ]
  }
}

#####################
# Resources & Modules
#####################
resource "aws_iam_role" "controltower_cloudtrail" {
  name               = "AWSControlTowerCloudTrailRole"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_cloudtrail_cloudtrail.json

  tags = merge(
    {
      Name                 = "AWSControlTowerCloudTrailRole"
      "root:iam-role:path" = "/service-role/"
    },
    local.shared_tags,
  )
}

resource "aws_iam_role_policy" "controltower_cloudtrail_inline" {
  name   = "AWSControlTowerAdminPolicy"
  role   = aws_iam_role.controltower_cloudtrail.name
  policy = data.aws_iam_policy_document.controltower_cloudtrail_inline.json
}
