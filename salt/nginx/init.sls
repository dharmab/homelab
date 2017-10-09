{% from "nginx/map.jinja" import nginx with context %}
{% set nginx_virtual_hosts = salt['pillar.get']('nginx_virtual_hosts', {}) %}

include:
  - firewalld

nginx:
  pkg.installed:
    - name: nginx
  service.running:
    - name: nginx
    - enable: True
    - require:
      - pkg: nginx
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/files/nginx.conf
    - template: jinja
    - defaults:
        virtual_hosts: {{ nginx_virtual_hosts }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx
  cmd.run:
    - name: firewall-cmd --zone=public --add-service=http --permanent && firewall-cmd --zone=public --add-service=https --permanent
    - unless: firewall-cmd --zone=public --query-service=http && firewall-cmd --zone=public --query-service=https
    - watch_in:
      - service: firewalld
