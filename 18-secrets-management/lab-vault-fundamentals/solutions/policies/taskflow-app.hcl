# TaskFlow application — read-only access to app secrets
path "secret/data/taskflow/app/*" {
  capabilities = ["read", "list"]
}

path "secret/metadata/taskflow/app/*" {
  capabilities = ["read", "list"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}