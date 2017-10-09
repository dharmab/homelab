firewalld:
  service.running:
    - name: firewalld
    - enable: yes
  firewalld.present:
    - name: public
    # Add all ethernet and wireless interfaces to the public zone
    - interfaces: 
      {% for interface in grains['ip_interfaces'].keys() %}
      {% if interface|first in ['e', 'w'] %}
      - {{ interface }}
      {% endif %}
      {% endfor %}
    # Don't delete any services configured by other states
    - prune_services: False
    # Don't add the interfaces until the end of the first run so that other
    # states can configure their services before policy is applied to public
    # interfaces
    - order: last
