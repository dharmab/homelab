{% set salt = salt['pillar.get']('salt', {}) %}

include:
  - salt

salt_minion:
  pkg.installed:
    - name: salt-minion
  service.running:
    - name: salt-minion
    - require:
      - pkg: salt-minion
  file.serialize:
    - name: /etc/salt/minion
    {% if salt.minion_config is defined %}
    - dataset_pillar: salt:minion_config
    {% else %}
    - dataset: {}
    {% endif %}
    - formatter: yaml
    - user: root
    - group: root
    - mode: 600

salt_minion_restart:
  cmd.wait:
    - name: 'salt-call --local service.restart salt-minion'
    - bg: True
    - onchanges:
      - pkg: salt_minion
      - file: salt_minion
