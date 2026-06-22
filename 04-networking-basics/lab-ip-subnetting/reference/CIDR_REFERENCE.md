# CIDR Quick Reference

| CIDR | Hosts | Mask |
|------|-------|------|
| /32 | 1 | 255.255.255.255 |
| /24 | 254 | 255.255.255.0 |
| /20 | 4,094 | 255.255.240.0 |
| /16 | 65,534 | 255.255.0.0 |

## Formulas

- **Network address:** IP AND subnet mask
- **Broadcast:** network OR (NOT mask)
- **Usable hosts:** 2^(32-prefix) - 2 (IPv4)

## TaskFlow example

`10.20.0.0/16` (staging VPC) → subnets:

- `10.20.1.0/24` public web
- `10.20.10.0/24` private app
- `10.20.20.0/24` private data