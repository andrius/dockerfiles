socat
=====

In case if openconnect will be started on Debian VPS, port 1080 will be locked only to 127.0.0.1, perhaps because of openconnect tun routing.
Connections to the mapped port would be rejected.

Socat can fix that ;)

Following command will forward port 1082 to the docker container with IP 172.17.0.5, port 1080

```bash
socat tcp-listen:1082,reuseaddr,fork tcp:172.17.0.5:1080
```
