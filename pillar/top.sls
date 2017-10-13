base:
  'server*':
    - network
    - salt.minion
  'server-1':
    - salt.master
    - bind.master
    - prometheus.server
    - grafana
    - grafana.dashboards
  'server-2':
    - bind.slave
