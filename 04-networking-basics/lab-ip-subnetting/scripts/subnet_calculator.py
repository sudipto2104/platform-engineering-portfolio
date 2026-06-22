#!/usr/bin/env python3
"""Simple CIDR subnet calculator for Week 4 lab."""
from __future__ import annotations

import ipaddress
import sys


def describe(cidr: str) -> None:
    net = ipaddress.ip_network(cidr, strict=False)
    hosts = net.num_addresses - 2 if net.version == 4 and net.prefixlen < 31 else net.num_addresses
    print(f"CIDR:        {net}")
    print(f"Network:     {net.network_address}")
    print(f"Broadcast:   {net.broadcast_address}")
    print(f"Netmask:     {net.netmask}")
    print(f"Prefix:      /{net.prefixlen}")
    print(f"Usable hosts:{hosts}")


def main() -> None:
    if len(sys.argv) < 2:
        print("Usage: subnet_calculator.py <CIDR>")
        sys.exit(2)
    describe(sys.argv[1])


if __name__ == "__main__":
    main()