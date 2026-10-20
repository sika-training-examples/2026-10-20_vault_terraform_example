resource "vault_policy" "super_admin" {
  name = "super-admin"

  policy = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list", "sudo"]
}
EOT
}
