#####################
# Resources & Modules
#####################
resource "aws_organizations_organizational_unit" "core" {
  name      = "core"
  parent_id = aws_organizations_organization.root.roots[0].id

  tags = merge(
    {
      Name = "core"
    },
    local.shared_tags,
  )
}
