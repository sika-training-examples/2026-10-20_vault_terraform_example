resource "vault_policy" "secret_read" {
  name = "secret-read"

  policy = <<EOT
path "secret/data/*" {
  capabilities = ["read"]
}
path "secret/metadata/*" {
  capabilities = ["list"]
}
EOT
}
