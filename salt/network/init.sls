{% from "network/map.jinja" import network with context %}

network:
  service.running:
    - name: network
    - enable: True

# Disable NetworkManager so it doesn't overwrite our settings
network_networkmanager:
  service.dead:
    - name: NetworkManager
    - enable: False

network_resolvers:
  {% if not network.resolvers %}
  test.fail_without_changes:
    - name: network.resolvers is undefined
    - failhard: True
  {% else %}
  file.managed:
    - name: /etc/resolv.conf
    - source: salt://network/files/resolv.conf
    - template: jinja
    - defaults:
        resolvers: {{ network.resolvers }}
        search_domain: {{ network.search_domain|default(grains['domain']) }}
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: network
  {% endif %}

{% for interface in grains['ip_interfaces'] %}
{% if interface|first in ['e', 'w'] %}
network_peerdns_{{ loop.index }}:
  file.replace:
    - name: /etc/sysconfig/network-scripts/ifcfg-{{ interface }}
    - pattern: '^PEERDNS=.*$'
    - repl: 'PEERDNS=no'
    - append_if_not_found: True
    - watch_in:
      - service: network
{% endif %}
{% endfor %}
