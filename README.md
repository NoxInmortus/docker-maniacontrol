# Docker - ManiaControl

This container contain PHP-7.2 and ManiaControl.

Version 1.2

Works great with https://git.tools01.imperium-gaming.fr/sysadmins/docker/docker-trackmania

## Official NoxInmortus repositories

Find more at :
- https://git.tools01.imperium-gaming.fr/
- https://github.com/NoxInmortus?tab=repositories

## Available Architectures
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
 trackmania/docker-maniacontrol
```

## Sources
- https://github.com/ManiaControl/ManiaControl
- https://github.com/docker/cli/tree/master/experimental
- https://mirailabs.io/blog/multiarch-docker-with-buildx/
