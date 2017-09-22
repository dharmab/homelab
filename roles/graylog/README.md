# Graylog

Installs Graylog using the [minimum setup single-node architecture](http://docs.graylog.org/en/2.3/pages/architecture.html#minimum-setup)

## Variables

- `graylog_root_password`: Password for the `admin` account. Required.
- `graylog_password_secret_seed`: Secret used to generate the password secret, which is used to protect the root password on disk. May be any arbitrary string. Required.
- `graylog_open_port`: If `True`, direct external access to the Graylog web UI/API port is enabled. Otherwise, external access is disabled and a reverse proxy is required to access Graylog. The default is `False`.

## Syslog Input Ports

6514/udp and 6514/tcp are opened for use as IETF-syslog input ports.

## Setup

- Go to the Graylog web UI and log in
- Click System > Inputs
- Select "Syslog TCP" or "Syslog UDP" and click "Launch new input"
- Configure the input:
  - Global: True
  - Bind address: 0.0.0.0
  - Port: 6514
