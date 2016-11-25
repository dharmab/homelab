# NTP

Manages NTP on a CentOS 7 server as a client or host.

## Variables

- `ntp_is_server`: If `true`, this system will be configured as an NTP server. Otherwise, this system will be configured as an NTP client only. The default is `false`
- `ntp_servers`: List of servers to synchronize time with. The default are servers provided by the [NTP Pool Project](http://www.pool.ntp.org/en/use.html)
