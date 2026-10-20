locals {
  allowed_redirect_uris = [
    "https://vault.sikademo.com/ui/vault/auth/oidc/oidc/callback",
    "http://localhost:8250/oidc/callback",
  ]
}

resource "vault_jwt_auth_backend" "oidc" {
  type               = "oidc"
  path               = "oidc"
  oidc_discovery_url = "https://sso.sikalabs.com/realms/training"
  oidc_client_id     = "example_client_id"
  oidc_client_secret = "example_client_secret"
  default_role       = "default"
}

resource "vault_jwt_auth_backend_role" "default" {
  backend               = vault_jwt_auth_backend.oidc.path
  role_name             = "default"
  role_type             = "oidc"
  bound_audiences       = [vault_jwt_auth_backend.oidc.oidc_client_id]
  allowed_redirect_uris = local.allowed_redirect_uris
  user_claim            = "email"
  oidc_scopes           = ["openid", "profile", "email", "groups"]
  token_policies        = [vault_policy.super_admin.name]
}
