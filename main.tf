data "aws_ssoadmin_instances" "ssos" {}

resource "aws_ssoadmin_permission_set" "permissionset" {
  name             = var.name
  description      = var.name
  instance_arn     = tolist(data.aws_ssoadmin_instances.ssos.arns)[0]
}

resource "aws_ssoadmin_managed_policy_attachment" "permissionset_policy" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.ssos.arns)[0]
  managed_policy_arn = var.policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.permissionset.arn
}

data "aws_identitystore_group" "groups" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssos.identity_store_ids)[0]

  filter {
    attribute_path  = "DisplayName"
    attribute_value = var.name
  }
}

resource "aws_ssoadmin_account_assignment" "assignment" {
  for_each = var.accounts
  instance_arn       = aws_ssoadmin_permission_set.permissionset.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.permissionset.arn

  principal_id   = data.aws_identitystore_group.groups.group_id
  principal_type = "GROUP"

  target_id   = each.value
  target_type = "AWS_ACCOUNT"
}
//info