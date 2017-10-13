## Grafana

Installs [Grafana](https://grafana.com/), a time-series data analytics tool.

### Pillar

- `grafana.grafana_url`: URL of the Grafana server; required by Salt. Recommended value: `http://localhost:3000`
- `grafana.grafana_user`: Name of the Grafana admin user managed and required by Salt. Recommended value: `salt`.
- `grafana.grafana_password`: Password of the Grafana admin user managed and required by Salt.
- `grafana.datasources`: List of Grafana datasources to configure. Each element must be a dictionary containing the keys used by the `grafana4_datasource.present` function (except `orgname`). See [Salt documenation](https://docs.saltstack.com/en/latest/ref/states/all/salt.states.grafana4_datasource.html#salt.states.grafana4_datasource.present) for details. The default is an empty list.
- `grafana.dashboards`: List of Grafana datasources to configure. Each element must be a dictionary containing the following keys. This is not intended to be maintained by hand. See the 'Exporting Dashboards' section below. The default is an empty list.
  - `slug`: The dashboard's slug title.
  - `content`: Dictionary containing the dashboard's content, as defined in the Grafana API.
- `grafana.open_port`: If `True`, the Grafana server port (3000/TCP) will be open. Intended for development use only. The default is `False`.

## Exporting Dashboards

A script is provided to export the dashboards from a Grafana instance into the Pillar format required by `grafana.dashboards`. To use it, run the following:

```
export GRAFANA_URL=<grafana.grafana_url>
export GRAFANA_USER=<grafana.grafana_user>
export GRAFANA_PASSWORD=<grafana.grafana_password>
./scripts/export.py > dashboards.sls
```

## Reverse Proxy

In production, it is recommended to use the `nginx` state to configure the following Nginx virtual host:

```
nginx_virtual_hosts:
  grafana:
    names:
      - <grafana server fqdn>
    type: proxy
    proxy_addresses:
      - localhost:3000
```
