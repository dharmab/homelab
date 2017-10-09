# Syslog

Configures log shipping using [syslog-ng](https://syslog-ng.org/?utm_source=documentation&utm_medium=webhelp&utm_campaign=ose).

## States

- `syslog`: Configures syslog-ng to ship logs.

## Pillar

- `syslog_destinations`: List of destinations to ship logs to. Each destination must be a dictionary containing `host`, `port` and `transport` keys. The default is an empty list.
  - `host`: Host where logs will be shipped.
  - `port`: Syslog port on host.
  - `transport`: Syslog transport to use. One of `udp`, `tcp` or `tls`.

## Notes

For free log shipping destinations, check out the following providers:

- [DataDog](https://www.datadoghq.com)
- [Loggly](https://www.loggly.com/)
- [Papertrail](https://papertrailapp.com/)
- [Sumo Logic](https://www.sumologic.com)

If you prefer something on-site, checkout out the following open-source products. There are not for the weak of hard or low of budget!

- [ELK](https://www.elastic.co/products) (Elasticsearch + Logstash + Kibana)
- [Graylog](https://www.graylog.org/)
