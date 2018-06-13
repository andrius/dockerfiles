
```bash
docker run -ti --rm \
  -p 127.0.0.1:57575:57575/tcp \
  -e BUTTERFLY_USER=ak \
  -e BUTTERFLY_PASSWORD=password \
  andrius/butterfly --login --port=57575
```
