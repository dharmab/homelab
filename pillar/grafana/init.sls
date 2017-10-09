grafana:
  grafana_url: http://localhost:3000
  grafana_user: grafana
  grafana_password: grafana
  datasources: 
    - name: Prometheus
      type: prometheus
      url: http://prometheus.lab.dharmab.com
      access: proxy
      is_default: True
  open_port: True
nginx_virtual_hosts:
  grafana:
    names:
      - grafana.lab.dharmab.com
    type: proxy
    proxy_addresses:
      - localhost:3000
