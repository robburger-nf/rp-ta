#####################
# Resources & Modules
#####################
resource "aws_organizations_organizational_unit" "sandbox" {
  name      = "sandbox"
  parent_id = aws_organizations_organization.root.roots[0].id

  tags = merge(
    {
      Name = "sandbox"
    },
    local.shared_tags,
  )
}
