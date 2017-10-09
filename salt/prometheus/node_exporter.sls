include:
  - firewalld

prometheus_node_exporter:
  service.running:
    - name: node_exporter
    - enable: True
  file.managed:
    - name: /etc/systemd/system/node_exporter.service
    - source: salt://prometheus/files/node_exporter.service
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: node_exporter
    - watch:
      - service: docker

prometheus_node_exporter_firewalld:
  firewalld.service:
    - name: nodeexporter
    - ports:
      - 9100/tcp
  cmd.run:
    - name: firewall-cmd --zone=public --add-service=nodeexporter --permanent
    - unless: firewall-cmd --zone=public --query-service=nodeexporter
    - require:
      - firewalld: prometheus_node_exporter_firewalld
    - watch_in:
      - service: firewalld
