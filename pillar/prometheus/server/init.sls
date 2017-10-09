prometheus:
  open_server_ports: True
  server_config:
    scrape_configs:
      - job_name: node_exporter
        dns_sd_configs:
          - names:
            - _node_exporter._tcp.lab.dharmab.com.
      - job_name: cadvisor
        dns_sd_configs:
          - names:
            - _cadvisor._tcp.lab.dharmab.com.
nginx_virtual_hosts:
  prometheus_server:
    names:
      - prometheus.lab.dharmab.com
    type: proxy
    proxy_addresses:
      - localhost:9090
