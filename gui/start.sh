#!/usr/bin/env bash

# 1280x1024 default
# 1365x1024 best on ipad pro (full resolution is 2048x1536)
docker run -ti --rm \
  -e VNC_RESOLUTION=1364x1024 \
  -p 0.0.0.0:50522:22 \
  -p 0.0.0.0:3389:3389 \
  -p 0.0.0.0:5900:5900 \
  --name=gui \
  gui

