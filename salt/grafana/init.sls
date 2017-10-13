{% from "grafana/map.jinja" import grafana with context %}

grafana:
  pkgrepo.managed:
    - name: grafana
    - humanname: grafana
    - baseurl: https://packagecloud.io/grafana/stable/el/{{ grains['osmajorrelease'] }}/$basearch
    - enabled: True
    - gpgcheck: 1
    - gpgkey: https://packagecloud.io/gpg.key https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana
    - sslcacert: /etc/pki/tls/certs/ca-bundle.crt
    - sslverify: 1
  pkg.installed:
    - name: grafana
    - require:
      - pkgrepo: grafana
  file.managed:
    # Replace with ini.options_present after upgrading to salt 2017.7.2
    # https://github.com/saltstack/salt/issues/42382
    - name: /etc/grafana/grafana.ini
    - source: salt://grafana/files/grafana.ini
    - user: root
    - group: grafana
    - mode: 640
    - template: jinja
    - defaults:
        admin_user: {{ grafana.grafana_user }}
        admin_password: {{ grafana.grafana_password }}
    - watch_in:
      - service: grafana
  service.running:
    - name: grafana-server
    - enable: True
    - require:
      - pkg: grafana
  grafana4_org.present:
    - name: 'Main Org.'
    - require:
      - service: grafana

{% for datasource in grafana.datasources %}
grafana_datasource_{{ loop.index }}:
  grafana4_datasource.present:
    - orgname: 'Main Org.'
    {% for key, value in datasource.iteritems() %}
    - {{ key }}: {{ value }}
    {% endfor %}
    - require:
      - service: grafana
      - grafana4_org: grafana
{% endfor %}

{% for dashboard in grafana.dashboards %}
grafana_dashboard_{{ loop.index }}:
  grafana4_dashboard.present:
    - name: {{ dashboard.slug }}
    - dashboard: {{ dashboard.content }}
{% endfor %}

grafana_firewalld:
  firewalld.service:
    - name: grafana
    - ports:
      - 3000/tcp
  cmd.run:
    {% if grafana.open_port %}
    - name: firewall-cmd --zone=public --add-service=grafana --permanent
    - unless: firewall-cmd --zone=public --query-service=grafana
    {% else %}
    - name: firewall-cmd --zone=public --remove-service=grafana --permanent
    - onlyif: firewall-cmd --zone=public --query-service=grafana
    {% endif %}
    - require:
      - firewalld: grafana_firewalld
    - watch_in:
      - service: firewalld
