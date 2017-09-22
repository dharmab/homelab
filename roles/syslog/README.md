# Syslog

Configures syslog-ng to ship logs.

## Variables

- `syslog_destinations`: List of destinations to ship logs to. Each destination must be a dictionary containing `host` and `port`. The default is an empty list.
  - `host`: Host where logs will be shipped.
  - `port`: Syslog port on host.
  - `transport`: Syslog transport to use. One of `udp`, `tcp` or `tls`.

