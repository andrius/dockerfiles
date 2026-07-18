# CLAUDE.md

Monorepo of many small "dockerized applications", one Dockerfile per subdirectory. Own repo (Andrius).

- No root Dockerfile; each subdir builds independently (butterfly, certbot, curl, dante, jitsi-meet, nmap, novnc, sipp, sngrep, sshd, sslh, stunnel, tmux, terminal-slack, wscat, and more).
- See `README.md` for the per-app index and links.
- Build a given app: `docker build -t <app> ./<app>`.
- Last commit: 2021-03-10.
