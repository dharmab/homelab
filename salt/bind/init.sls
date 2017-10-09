{% from 'bind/map.jinja' import bind with context %}

include:
  - firewalld

bind:
  pkg.installed:
    - name: bind
  service.running:
    - name: named
    - enable: True
    - require:
      - pkg: bind
  file.managed:
    - name: /etc/named.conf
    - source: salt://bind/files/named.conf
    - user: root
    - group: named
    - mode: 640
    - template: jinja
    - defaults:
        forwarders: {{ bind.forwarders }}
        zones: {{ bind.zones }}
    - context:
        {% if bind.allowed_clients is defined %}
        allowed_clients: {{ bind.allowed_clients }}
        {% endif %}
        {% if bind.allowed_slaves is defined %}
        allowed_slaves: {{ bind.allowed_slaves }}
        {% endif %}
    - check_cmd: named-checkconf
    - watch_in:
      - service: bind

{% for zone, config in bind.zones.iteritems() %}
{% if config.type == 'master' %}
bind_zone_{{ loop.index }}:
  module.run:
    - name: dnsutil.serial
    - update: True
    - zone: {{ zone }}
    - prereq:
      - file: bind_zone_{{ loop.index }}
  file.managed:
    - name: /var/named/{{ zone }}.zone
    - source: salt://bind/files/master.zone
    - user: named
    - group: named
    - mode: 640
    - template: jinja
    - defaults:
       origin: {{ zone }}
       config: {{ config}}
    - check_cmd: named-checkzone {{ zone }}
    - watch_in:
      - service: bind
{% endif %}
{% endfor %}

bind_firewalld:
  cmd.run:
    - name: firewall-cmd --zone=public --add-service=dns --permanent
    - unless: firewall-cmd --zone=public --query-service=dns
    - watch_in:
      - service: firewalld
