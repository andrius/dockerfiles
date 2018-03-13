#!/bin/sh

# socat tcp-listen:1082,reuseaddr,fork tcp:172.17.0.5:1080
command_line="socat tcp-listen:${LISTEN_PORT},reuseaddr,fork tcp:${FORWARD_TO}"
echo -e "socat command line:\n${command_line}"
exec ${command_line}
