resource "vault_policy" "auto_unseal" {
  name = "auto-unseal"

  policy = <<EOT
path "transit/encrypt/autounseal" {
  capabilities = ["update"]
}

path "transit/decrypt/autounseal" {
  capabilities = ["update"]
}
EOT
}


