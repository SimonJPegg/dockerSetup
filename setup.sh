#!/usr/bin/env bash

set -e

vagrant up
ansible-playbook playbooks/nfs.yaml
ansible-playbook playbooks/swarm.yaml
