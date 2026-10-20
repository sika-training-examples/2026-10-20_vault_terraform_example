resource "vault_policy" "secret_write" {
  name = "secret-write"

  policy = <<EOT
path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "secret/metadata/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}
