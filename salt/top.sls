base:
  'server-1':
    - grafana
    - nginx
    - prometheus.server
    - salt.master
  'server*':
    - bind
    - firewalld
    - network
    - ntp
    - openssh
    - prometheus.cadvisor
    - prometheus.node_exporter
    - salt.minion
    - syslog
    - system
