# Docker - ManiaControl

This container contain PHP-7.4 and ManiaControl.

## Available Architectures (since 0.2)
- amd64
- arm64 (aarch64)
- armv7 (arm)

## Minimal Startup

```
docker run --name=maniacontrol -d -v maniacontrol:/maniacontrol \
  -e MANIAPLANET_SERVER_ADDRESS='maniaplanet' \
  -e MANIAPLANET_XMLRPC_PORT='5000' \
  -e MANIAPLANET_XMLRPC_LOGIN='SuperAdmin' \
  -e MANIAPLANET_XMLRPC_PASSWORD='P@55w0rd' \
  -e MYSQL_SERVER_ADDRESS='mariadb' \
  -e MYSQL_SERVER_PORT='3306' \
  -e MYSQL_USER='maniacontrol' \
  -e MYSQL_PASSWORD='dbP@65w0rd' \
  -e MYSQL_DATABASE='maniacontrol' \
  -e MASTER_ADMIN_USER= 'xXxGaMeRxXx' \
 albanosdes/docker-maniacontrol
```

## Dev/Build
```
# Dockerhub
docker build -t albanosdes/docker-maniacontrol -t albanosdes/docker-maniacontrol:0.x .
docker push albanosdes/docker-maniacontrol && docker push albanosdes/docker-maniacontrol:0.x

Multiarch :
* `docker buildx build -t albanosdes/docker-maniacontrol -t albanosdes/docker-maniacontrol:0.x --platform=linux/aarch64,linux/amd64,linux/arm . --push`
```


## Sources
- https://github.com/ManiaControl/ManiaControl
- https://github.com/docker/cli/tree/master/experimental
- https://mirailabs.io/blog/multiarch-docker-with-buildx/
