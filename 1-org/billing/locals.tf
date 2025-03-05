locals {
  lz_config             = yamldecode(file("../../lzconfig.yaml"))
  account_id_management = data.aws_organizations_organization.org.master_account_id
  account_id_billing    = data.terraform_remote_state.remote.outputs.accounts_id_map.billing
}