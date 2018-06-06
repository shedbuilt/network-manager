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
            --without-iptables                              \
            --with-udev-dir=/lib/udev                       \
            --with-session-tracking=systemd                 \
            --with-systemdsystemunitdir=/lib/systemd/system \
            --docdir=/usr/share/doc/network-manager-1.10.6 &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
install -v -Dm644 "${SHED_PKG_CONTRIB_DIR}/NetworkManager.conf" "${SHED_FAKE_ROOT}/etc/NetworkManager/NetworkManager.conf.default"
