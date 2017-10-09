{% from 'prometheus/map.jinja' import prometheus with context %}

include:
  - docker

prometheus_server:
  file.managed:
    - name: /etc/systemd/system/prometheus.service
    - source: salt://prometheus/files/prometheus.service
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: prometheus_server
  service.running:
    - name: prometheus
    - enable: True
    - watch:
      - service: docker

prometheus_server_config:
  file.serialize:
    - name: /etc/prometheus/prometheus.yml
    {% if prometheus.server_config is defined %}
    - dataset_pillar: "prometheus:server_config"
    {% else %}
    - dataset: {}
    {% endif %}
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - watch_in:
      - service: prometheus_server

prometheus_firewalld:
  firewalld.service:
    - name: prometheus
    - ports:
      - 9090/tcp
  cmd.run:
  {% if prometheus.open_server_ports %}
    - name: firewall-cmd --zone=public --add-service=prometheus --permanent
    - unless: firewall-cmd --zone=public --query-service=prometheus
  {% else %}
    - name: firewall-cmd --zone=public --remove-service=prometheus --permanent
    - onlyif: firewall-cmd --zone=public --query-service=prometheus
  {% endif %}
    - require:
      - firewalld: prometheus_firewalld
    - watch_in:
      - service: firewalld
