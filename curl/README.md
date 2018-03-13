cURL command line tool and library for transferring data with URLs
==================================================================

cURL (https://curl.haxx.se) in docker.

There is many reasons to use curl: to download files, to test HTTP REST API. In my case, I do use VPN and socks servers with docker and often have to check IP address

Usage sample:

```bash
docker run -ti --rm andrius/curl curl ifconfig.co
```

and with proxy:

```bash
docker run -ti -e "ALL_PROXY=some.proxy.url:1080" --rm andrius/curl curl ifconfig.co
```
