# Homelab

## Architecture

This Homelab has two servers. `server-1` is the primary server (Salt master) and `server-2` is a secondary server for redundant core services. Eventually I'd add some Windows systems to this lab as well.

## Getting Started

1. Run `vagrant up` to launch both servers and bootstrap them.
1. Run `vagrant ssh` to log into the primary server.
1. Run `sudo salt '*' state.highstate` until everything succeeds. It may take multiple runs to resolve networking. Hooray mutable infrastructure.
1. Run `sudo salt '*' service.restart docker` to work around a known issue with firewalld and Docker.

Prometheus will be accessible at http://localhost:9090, and Grafana will be accessible at http://localhost:3000.
