# Docker

Installs and starts Docker.

## States

- `docker`: Install and start Docker.

## Sample Docker systemd Unit

```
{%- set image = 'registry/image:version' -%}
{%- set name = 'myservice' -%}
[Unit]
Description=My Service
After=docker.service
Requires=docker.service
 
[Service]
Restart=always
ExecStartPre=-/usr/bin/docker stop {{ name }}
ExecStartPre=-/usr/bin/docker rm {{ anme }}
ExecStartPre=/usr/bin/docker pull {{ image }}
ExecStart=/usr/bin/docker run --rm \
--name {{ name }} \
<docker run arguments>
{{ image }} \
<image arguments>
 
[Install]
WantedBy=multi-user.target
```

## Known Issues

- Docker container networking will fail when firewalld is restarted. See [Docker documentation](https://docs.docker.com/v1.6/installation/centos/#firewalld) for details. It may be necessary to restart Docker manually after firewall changes are made. Docker services should use `Restart=always` in their systemd units to automatically restart after Docker restarts.
