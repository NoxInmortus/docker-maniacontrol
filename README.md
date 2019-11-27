# Docker - ManiaControl

This container contain PHP-7.3 and ManiaControl.

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
 registry.imperium-gaming.fr/imperium/docker-maniacontrol
```

## Dev/Build
```
# Login
docker login registry.imperium-gaming.fr

# Build git.imperium-gaming.fr
docker build -t registry.imperium-gaming.fr/imperium/docker-maniacontrol -t registry.imperium-gaming.fr/imperium/docker-maniacontrol:0.x .

# Push git.imperium-gaming.fr
docker push registry.imperium-gaming.fr/imperium/docker-maniacontrol:latest && docker push registry.imperium-gaming.fr/imperium/docker-maniacontrol:0.x


# Build dockerhub
docker build -t albanosdes/docker-maniacontrol -t albanosdes/docker-maniacontrol:0.x .

# Push dockerhub
docker push albanosdes/docker-maniacontrol && docker push albanosdes/docker-maniacontrol:0.x
```

## Sources
- https://github.com/ManiaControl/ManiaControl
