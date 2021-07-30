#!/bin/sh

set -e

ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
wg-quick up /etc/wireguard/$ifname.conf
ifinet=$(ifconfig $ifname | grep "inet addr:" | cut -d: -f2 | awk '{ print $1}')
sed -i -e "s/__replace_me_ifname__/$ifname/" /etc/sockd.conf
sed -i -e "s/__replace_me_ifinetip__/$ifinet/" /etc/tinyproxy.conf

/usr/sbin/sockd
/usr/bin/tinyproxy -c /etc/tinyproxy.conf