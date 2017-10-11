{% from 'ntp/map.jinja' import ntp with context %}

ntp:
  pkg.installed:
    - name: ntp
  service.running:
    - name: ntpd
    - enable: True
    - require:
      - pkg: ntp
  file.managed:
    - name: /etc/ntp.conf
    - source: salt://ntp/files/ntp.conf
    - user: root
    - group: root
    - template: jinja
    - defaults:
        is_server: {{ ntp.is_server }}
        ntp_servers: {{ ntp.servers }}
    - watch_in:
      - service: ntp

ntp_firewall:
  cmd.run:
    {% if ntp.is_server %}
    - name: firewall-cmd --zone=public --add-service=ntp --permanent
    - unless: firewall-cmd --zone=public --query-service=ntp
    {% else %}
    - name: firewall-cmd --zone=public --remove-service=ntp --permanent
    - onlyif: firewall-cmd --zone=public --query-service=ntp
    {% endif %}
    - watch_in:
      - service: firewalld
