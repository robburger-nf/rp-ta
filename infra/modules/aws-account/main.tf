#####################
# Resources & Modules
#####################
resource "aws_organizations_account" "this" {
  email                      = "tech+aws_${var.email_suffix}@rootplatform.com"
  name                       = var.name
  iam_user_access_to_billing = var.iam_user_access_to_billing
  parent_id                  = var.parent_id
  role_name                  = var.role_name

  tags = merge(
    {
      Name = var.name
    },
    var.tags,
  )
}
