# Wireguard-Socks

Expose WireGuard as a SOCKS5 proxy in a Docker container.

## Usage

```bash
docker run -it --rm --cap-add=NET_ADMIN \
    --name wireguard-socks-proxy \
    --volume /directory/containing/your/wireguard/conf/file/:/etc/wireguard/:ro \
    -p 1080:1080 \
    ghcr.io/apocalypsor/wireguard-socks
```

Then connect to SOCKS proxy through through `127.0.0.1:1080` (or `local.docker:1080` for Mac / docker-machine / etc.). For example:

```bash
curl --proxy socks5h://127.0.0.1:1080 ipinfo.io
```

## Troubleshooting

### I get "Permission Denied"

This can happen if your WireGuard configuration file includes an IPv6 address but your host interface does not work with it. Try removing the IPv6 address in `Address` from your configuration file.
