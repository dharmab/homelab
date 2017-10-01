# Homelab

# Configuration

```
# Configure secrets
cp env.example.sh env.sh && vim env.sh
vagrant up
vagrant ssh ansible
# First run to bootstrap network services
/vagrant/run.sh
# Second run to provision systems
/vagrant/run.sh
```
