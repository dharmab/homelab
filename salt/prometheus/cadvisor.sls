include:
  - docker
  - firewalld

cadvisor:
  service.running:
    - name: cadvisor
    - enable: True
    - watch:
      - service: docker
  file.managed:
    - name: /etc/systemd/system/cadvisor.service
    - source: salt://prometheus/files/cadvisor.service
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - watch_in:
      - service: cadvisor

cadvisor_firewalld:
  firewalld.service:
    - name: cadvisor
    - ports:
      - 8080/tcp
  cmd.run:
    - name: firewall-cmd --zone=public --add-service=cadvisor --permanent
    - unless: firewall-cmd --zone=public --query-service=cadvisor
    - require:
      - firewalld: cadvisor_firewalld
    - watch_in:
      - service: firewalld
