# Firewalld

Enables and configures firewalld, the default firewall for CentOS 7. All ethernet and wireless interfaces will be added to firewalld' public zone

## States

- `firewalld`: Enable the firewall

## Opening Ports within States

```yaml
include:
  - firewalld

# Defining your service in firewalld will make it simpler to manage and is
# strongly recommended.
mystate_firewall:
  firewalld.service:
    - name: myservice
    - ports:
      - 1234/tcp
      - 1234/udp
# Invoke firewall-cmd using cmd.run; The firewalld.present does not provide a 
# way to make modular and atomic edits to a zone, nor does it allow modular 
# removal of services in a zone.
  cmd.run:
    - name: firewall-cmd --zone=public --add-service=myservice --permanent
    - unless: firewall-cmd --zone=public --query-service=myservice
    - require:
      - firewalld: mystate_firewall
    - watch_in:
      - service: firewalld
```

To close the port instead, use `--remove-service` instead of `--add-service`, and change `unless` to `onlyif` to invert the condition.
