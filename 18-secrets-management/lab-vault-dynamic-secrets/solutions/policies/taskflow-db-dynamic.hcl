# TaskFlow app — request short-lived database credentials only
path "database/creds/taskflow-app" {
  capabilities = ["read"]
}

path "database/creds/taskflow-readonly" {
  capabilities = ["read"]
}

# Allow lease renewal within max TTL
path "sys/leases/renew" {
  capabilities = ["update"]
}

path "sys/leases/lookup" {
  capabilities = ["update"]
}