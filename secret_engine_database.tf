resource "vault_mount" "database" {
  path = "database"
  type = "database"
}

resource "vault_database_secret_backend_connection" "my_postgres" {
  backend       = vault_mount.database.path
  name          = "my-postgres"
  allowed_roles = ["my-postgres-read-only"]

  postgresql {
    connection_url = "postgresql://{{username}}:{{password}}@lab0.sikademo.com:5432/postgres?sslmode=disable"
    username       = "postgres"
    password       = "pg"
  }
}

resource "vault_database_secret_backend_role" "my_postgres_read_only" {
  backend             = vault_mount.database.path
  name                = "my-postgres-read-only"
  db_name             = vault_database_secret_backend_connection.my_postgres.name
  creation_statements = [
    <<-EOF
    CREATE ROLE "{{name}}" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}' INHERIT;
    GRANT ro TO "{{name}}";
    EOF
  ]
  default_ttl         = 120   # 2m
  max_ttl             = 86400 # 24h
}
