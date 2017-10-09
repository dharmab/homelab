bind:
  forwarders:
    - 10.10.10.10
  zones:
    'lab.dharmab.com':
      type: slave
      masters:
        - 10.10.10.10
