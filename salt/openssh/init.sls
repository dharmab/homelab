include:
  - firewalld

openssh_server:
  pkg.installed:
    - name: openssh-server
  service.running:
    - name: sshd
    - enable: True
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://openssh/files/sshd_config
    - user: root
    - group: root
    - mode: 600
    - watch_in:
      - service: openssh_server

openssh_client:
  file.managed:
    - name: /etc/ssh/ssh_config
    - source: salt://openssh/files/ssh_config
    - user: root
    - group: root
    - mode: 644

openssh_firewalld:
  cmd.run:
    - name: firewall-cmd --zone=public --add-service=ssh --permanent
    - unless: firewall-cmd --zone=public --query-service=ssh
    - watch_in:
      - service: firewalld
