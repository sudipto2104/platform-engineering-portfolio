# Compliance — audit and lease governance for TaskFlow secrets
path "sys/audit/*" {
  capabilities = ["read", "list"]
}

path "sys/audit" {
  capabilities = ["read", "list", "sudo"]
}

path "sys/leases/revoke" {
  capabilities = ["update"]
}

path "sys/leases/revoke-prefix/database/creds/taskflow-app/*" {
  capabilities = ["update"]
}

# Deny direct read of static DB passwords in KV
path "secret/data/taskflow/app/database" {
  capabilities = ["deny"]
}