#!/bin/bash

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
env_file="$script_dir/env.sh"
playbook="$script_dir/site.yml"

if [[ -f "$env_file" ]]; then
    . "$env_file"
fi

ansible-playbook "$playbook"
