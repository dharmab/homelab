# DHCP

Configures a CentOS 7 server as a DHCP server.

## Variables

- `dhcp_scopes`: List of DHCP scopes which will be configured. Each scope should be a hash containing the following key-value pairs. The default is an empty list.
  - `subnet`: The subnet ID of this DHCP scope. Example: `192.168.0.0`
  - `netmask`: The netmask of this DHCP scope. Example: `255.255.255.0`
  - `broadcast_address`: The broadcast address of the subnet. Example: `192.168.0.255`
  - `low_address`: The IPv4 address that marks the beginning of the dynamic assignment range (inclusive). Example: `192.168.0.2`
  - `high_address`: The IPv4 address that marks the end of the dynamic assignment range (inclusive). Example: `192.168.0.255`
  - `nameservers`: List of IPv4 addresses of nameservers serving this scope. Example: `[192.168.0.2, 192.168.0.3]`
  - `router`: The IPv4 address of the router serving this scope. Example: `192.168.0.1`
  - `default_lease_time`: The default lease time in seconds. Default: `600`
  - `max_lease_time`: The maximum lease time in seconds. Default: `7200`
