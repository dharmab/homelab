docker:
  pkg.installed:
    - name: docker
  service.running:
    - name: docker
    - enable: True
    - watch:
      - service: firewalld
