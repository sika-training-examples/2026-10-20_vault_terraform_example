resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "kubernetes" {
  backend         = vault_auth_backend.kubernetes.path
  kubernetes_host = "https://kubernetes.default.svc.cluster.local:443"
}

resource "vault_kubernetes_auth_backend_role" "kubernetes_read" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "read"
  bound_service_account_names      = ["*"]
  bound_service_account_namespaces = ["*"]
  token_policies                   = [vault_policy.secret_read.name]
  audience                         = "system:konnectivity-server"
  token_ttl                        = 86400 # 24h
}
