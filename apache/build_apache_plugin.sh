#!/bin/bash

set -eux

cd cwdapache

# Build so file
aclocal
libtoolize
autoheader
automake --force-missing --add-missing
autoreconf
./configure
make

# Create deb package
sudo mk-build-deps -i -r
dpkg-buildpackage -us -us
echo "Your Debian package should be in..." && ls ../libapache2-mod-auth-crowd_*.deb
