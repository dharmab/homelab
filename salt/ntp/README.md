# NTP

Configures [NTP](http://doc.ntp.org/current-stable), the reference implementation of Network Time Protocol.

## Variables

- `ntp.is_server`: If `True`, this system will be configured as an NTP server. Otherwise, this system will be configured as an NTP client only. The default is `False`
- `ntp.servers`: List of servers to synchronize time with. The default are servers provided by the [NTP Pool Project](http://www.pool.ntp.org/en/use.html)
