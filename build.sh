#!/bin/bash
CXXFLAGS="-O2 -fPIC"                                        \
./configure --prefix=/usr                                   \
            --sysconfdir=/etc                               \
            --localstatedir=/var                            \
            --with-nmtui                                    \
            --disable-ppp                                   \
            --disable-json-validation                       \
            --disable-ovs                                   \
            --disable-introspection                         \
            --with-udev-dir=/lib/udev                       \
            --with-session-tracking=systemd                 \
            --with-systemdsystemunitdir=/lib/systemd/system \
            --docdir=/usr/share/doc/network-manager-1.10.6 &&
make -j $SHED_NUMJOBS &&
make DESTDIR="$SHED_FAKEROOT" install &&
install -v -Dm644 "${SHED_CONTRIBDIR}/NetworkManager.conf" "${SHED_FAKEROOT}/etc/NetworkManager/NetworkManager.conf.default"
