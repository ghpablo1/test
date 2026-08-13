#!/bin/bash

set -e

mkdir -p /run/sshd
mkdir -p /var/log/supervisor

# SSH selalu listen di port 22
sed -i 's/^#\?Port .*/Port 22/' /etc/ssh/sshd_config

exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
