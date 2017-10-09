base:
  'server*':
    - network
    - salt.minion
  'server-1':
    - salt.master
    - bind.master
    - prometheus.server
    - grafana
  'server-2':
    - bind.slave
