resource "vault_userpass_auth_backend_user" "admin" {
  mount                = vault_auth_backend.userpass.path
  username             = "admin"
  password_wo          = "admin"
  password_wo_version  = 1

  token_policies = [
    vault_policy.super_admin.name,
  ]
  token_ttl      = 3600
  token_max_ttl  = 7200
}
