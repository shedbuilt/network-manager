#!/bin/bash
# If needed, create symlink to default NetworkManager config
if [ ! -e /etc/NetworkManager/NetworkManager.conf ]; then
    install -v -m644 /etc/NetworkManager/NetworkManager.conf.default /etc/NetworkManager/NetworkManager.conf || exit 1
fi
# In Amano, add resolve to nsswitch.conf if unmodified
SHED_PKG_NSSWITCH_HOSTS="$(sed -n 's/^hosts: //p' /etc/nsswitch.conf)"
if [ "$SHED_PKG_NSSWITCH_HOSTS" == 'files dns' ]; then
    sed -i "s/hosts: .*/hosts: files [NOTFOUND=return] resolve [!UNAVAIL=return] dns/g" /etc/nsswitch.conf
fi
# Bring down systemd-networkd interfaces
systemctl is-active systemd-networkd >/dev/null 2>&1
if [ $? -eq 0 ]; then
    systemctl disable systemd-networkd &&
    ip -a link set down
fi
# Bring up NetworkManager
systemctl is-active NetworkManager >/dev/null 2>&1
if [ $? -eq 0]; then
    systemctl restart NetworkManager
else
    systemctl enable NetworkManager
fi
