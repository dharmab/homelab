{% from 'syslog/map.jinja' import syslog with context %}

syslog:
  pkg.installed:
    - name: syslog-ng
  service.running:
    - name: syslog-ng
    - enable: True
    - require:
      - pkg: syslog
  file.managed:
    - name: /etc/syslog-ng/syslog-ng.conf
    - source: salt://syslog/files/syslog-ng.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
        destinations: {{ syslog.destinations }}
    - watch_in:
      - service: syslog
