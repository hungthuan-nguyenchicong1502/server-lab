#!/bin/sh
mkdir -p /root/.ssh
chown -R root:root /root/.ssh
chmod 700 /root/.ssh
# ssh authorized_keys
if [ -f "/root/.ssh/authorized_keys" ]; then
    chown -R root:root /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi
# ssh git id_ed25519
if [ -f "/root/.ssh/id_ed25519" ]; then
    chown -R root:root /root/.ssh/id_ed25519
    chmod 600 /root/.ssh/id_ed25519
fi

exec "$@"