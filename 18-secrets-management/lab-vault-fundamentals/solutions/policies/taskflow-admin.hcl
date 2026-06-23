# TaskFlow platform admin — full secrets management
path "secret/data/taskflow/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "secret/metadata/taskflow/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "auth/userpass/users/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}