# See: https://docs.aws.amazon.com/controltower/latest/userguide/access-control-managing-permissions.html#AWSControlTowerAdmin

######
# Data
######
data "aws_iam_policy_document" "assume_role_admin_controltower" {
  statement {
    sid = "AllowAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["controltower.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "controltower_admin_inline" {
  statement {
    sid = "AllowCTEC2"

    actions = [
      "ec2:DescribeAvailabilityZones",
    ]

    resources = [
      "*",
    ]
  }
}

#####################
# Resources & Modules
#####################
resource "aws_iam_role" "controltower_admin" {
  name               = "AWSControlTowerAdmin"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_admin_controltower.json

  tags = merge(
    {
      Name                 = "AWSControlTowerAdmin"
      "root:iam-role:path" = "/service-role/"
    },
    local.shared_tags,
  )
}

resource "aws_iam_role_policy" "controltower_admin_inline" {
  name   = "AWSControlTowerAdminPolicy"
  role   = aws_iam_role.controltower_admin.name
  policy = data.aws_iam_policy_document.controltower_admin_inline.json
}

resource "aws_iam_role_policy_attachment" "controltower_admin_service_role" {
  role       = aws_iam_role.controltower_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AWSControlTowerServiceRolePolicy"
}
