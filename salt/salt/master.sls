{% set salt = salt['pillar.get']('salt', {}) %}

include:
  - firewalld
  - salt

salt_master:
  pkg.installed:
    - name: salt-master
  service.running:
    - name: salt-master
    - enable: True
    - require:
      - pkg: salt-master
  file.serialize:
    - name: /etc/salt/master
    {% if salt.master_config is defined %}
    - dataset_pillar: salt:master_config
    {% else %}
    - dataset: {}
    {% endif %}
    - formatter: yaml
    - user: root
    - group: root
    - mode: 600
    - merge_if_exists: True

salt_firewalld:
  firewalld.service:
    - name: saltmaster
    - ports:
      - 4505/tcp
      - 4506/tcp
  cmd.run:
    - name: firewall-cmd --zone=public --add-service=saltmaster --permanent
    - unless: firewall-cmd --zone=public --query-service=saltmaster
    - require:
      - firewalld: salt_firewalld
    - watch_in:
      - service: firewalld
