andrius/gui
-----------

# About

Alpine linux xfce4 server with Firefox. Control with xrdp and vnc (vnc not ready yet)

# Usage

Start the server

```bash
docker run -d -e LOGIN_PASSWORD='my-new-password' --shm-size 1g --name rdp -p 3389:3389 andrius/gui
```

*note* --shm-size 1g is for firefox, without it it crashes

Connect with your favorite RDP client

Credentials:
User: alpine
Pass: alpine (or specify new one through `LOGIN_PASSWORD`)

