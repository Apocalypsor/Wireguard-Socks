# Wireguard-Socks

Expose WireGuard as a SOCKS5 proxy in a Docker container.

## Usage

1. Install Deps

```bash
sudo sh -c "echo 'deb http://deb.debian.org/debian buster-backports main contrib non-free' > /etc/apt/sources.list.d/buster-backports.list"
apt update
apt-get install wireguard-dkms wireguard-tools linux-headers-$(uname -r)
```

2. Docker Compose

```yaml
version: '3'

services:
  wg:
    image: ghcr.io/apocalypsor/wireguard-socks
    container_name: wg
    tty: true
    volumes:
      - ./wireguard:/etc/wireguard/:ro
    ports:
      - 1080:1080
      - 1081:1081
    privileged: true
    restart: unless-stopped
```

Then connect to SOCKS proxy through through `127.0.0.1:1080` or to HTTP proxy through through `127.0.0.1:1081` . For example:

```bash
curl --proxy socks5h://127.0.0.1:1080 ipinfo.io
```

## Troubleshooting

### I get "Permission Denied"

This can happen if your WireGuard configuration file includes an IPv6 address but your host interface does not work with it. Try removing the IPv6 address in `Address` from your configuration file.
