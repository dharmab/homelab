bind:
  forwarders:
    - 8.8.8.8
    - 8.8.4.4
  allowed_slaves:
    - 10.10.10.11
  zones:
    'lab.dharmab.com':
      type: master
      ttl: 300
      masters: 
        - 10.10.10.10
      nameserver: ns1.lab.dharmab.com
      email: dharmab.bellamkonda@gmail.com
      records:
        - type: NS
          resource: ns1.lab.dharmab.com.
        - type: A
          name: ns1
          resource: 10.10.10.10
        - type: NS
          resource: ns2.lab.dharmab.com.
        - type: A
          name: ns2
          resource: 10.10.10.11
        - type: A
          name: server01
          resource: 10.10.10.10
        - type: A
          name: server02
          resource: 10.10.10.11
        # BIND
        - type: CNAME
          name: bind01
          resource: server01
        - type: CNAME
          name: bind02
          resource: server02
        # Salt master
        - type: CNAME
          name: salt01
          resource: server01
        # Salt service discovery
        - type: CNAME
          name: salt
          resource: salt01
        # Prometheus
        - type: CNAME
          name: prometheus01
          resource: server01
        - type: CNAME
          name: prometheus
          resource: prometheus01
        # Grafana
        - type: CNAME
          name: grafana01
          resource: server01
        - type: CNAME
          name: grafana
          resource: grafana01
        # Prometheus exporter service discovery
        # Node exporter
        - type: SRV
          name: _node_exporter._tcp
          resource: 1 1 9100 server01
        - type: SRV
          name: _node_exporter._tcp
          resource: 1 1 9100 server02
        # cAdvisor
        - type: SRV
          name: _cadvisor._tcp
          resource: 1 1 8080 server01
        - type: SRV
          name: _cadvisor._tcp
          resource: 1 1 8080 server02
