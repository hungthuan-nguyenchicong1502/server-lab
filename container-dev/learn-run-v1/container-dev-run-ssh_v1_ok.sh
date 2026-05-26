#!/bin/sh
mkdir -p /root/.ssh
chown -R root:root /root/.ssh
chmod 700 /root/.ssh
# ssh authorized_keys
if [ -f "/tmp/root/.ssh/authorized_keys" ]; then
    cp -f /tmp/root/.ssh/authorized_keys /root/.ssh/authorized_keys
    chown -R root:root /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi
# ssh git id_ed25519
if [ -f "/tmp/root/.ssh/id_ed25519" ]; then
    cp -f /tmp/root/.ssh/id_ed25519 /root/.ssh/id_ed25519
    chown -R root:root /root/.ssh/id_ed25519
    chmod 600 /root/.ssh/id_ed25519
fi

exec "$@"