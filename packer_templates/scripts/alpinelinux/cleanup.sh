#!/bin/sh -eux

echo "Remove development and kernel source packages"
apk del alpine-sdk

echo "Removing extra firmware packages"
apk add --no-cache linux-firmware-none

echo "clean all package cache information"
rm -rf /var/cache/apk/*

echo "truncate any logs that have built up during the install"
find /var/log -type f -exec truncate -s 0 {} \;

echo "remove the contents of /tmp and /var/tmp"
rm -rf /tmp/* /var/tmp/*

echo "Clear the history so our install commands aren't there"
rm -f /root/.wget-hsts
export HISTSIZE=0
