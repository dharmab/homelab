# Salt

Install and configure [Salt](https://docs.saltstack.com/en/latest/), a powerful configuration management and automation tool.

## States

- `salt`: Install the SaltStack repository.
- `salt.master`: Install and configure the Salt master.
- `salt.minion`: Install and configure the Salt minion.

## Pillar

### salt.master

- `salt.master_config`: Literal dictionary containing master configuration. This is merged with the contents of `/etc/salt/master`. See [Salt documentation](https://docs.saltstack.com/en/latest/ref/configuration/master.html). A manual restart of the `salt-master` service is required for changes to take effect.

### salt.minion

- `salt.minion_config`: Literal dictionary containing minion configuration. This replaces the contents of `/etc/salt/minion`. See [Salt documentation](https://docs.saltstack.com/en/latest/ref/configuration/minion.html).
