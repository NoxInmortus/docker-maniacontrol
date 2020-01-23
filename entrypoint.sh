#!/usr/bin/env bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Set path
PATH=/bin:/sbin:/usr/bin:/usr/sbin

############
## CONFIG ##
############
echo '
--------------------------------------------

  ___ __  __ ____  _____ ____  ___ _   _ __  __
 |_ _|  \/  |  _ \| ____|  _ \|_ _| | | |  \/  |
  | || |\/| | |_) |  _| | |_) || || | | | |\/| |
  | || |  | |  __/| |___|  _ < | || |_| | |  | |
 |___|_|  |_|_|   |_____|_| \_\___|\___/|_|  |_|

--------------------------------------------

Brought to you by Imperium

--------------------------------------------'

## Setup /maniacontrol/configs/server.xml if absent
if [[ ! -f /maniacontrol/configs/server.xml ]]; then
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<maniacontrol>
        <server>
                <host>${MANIAPLANET_SERVER_ADDRESS}</host>
                <port>${MANIAPLANET_XMLRPC_PORT}</port>

                <user>${MANIAPLANET_XMLRPC_LOGIN}</user>
                <pass>${MANIAPLANET_XMLRPC_PASSWORD}</pass>
        </server>

        <database>
                <host>${MYSQL_SERVER_ADDRESS}</host>
                <port>${MYSQL_SERVER_PORT}</port>

                <user>${MYSQL_USER}</user>
                <pass>${MYSQL_PASSWORD}</pass>

                <name>${MYSQL_DATABASE}</name>
        </database>

        <masteradmins>
                <login>${MASTER_ADMIN_USER}</login>
        </masteradmins>
</maniacontrol>" > /maniacontrol/configs/server.xml
fi

# Set trap to stop the script proprely when a docker stop is executed
trap : EXIT TERM KILL INT SIGKILL SIGTERM SIGQUIT

# netcat test mysql
if [[ $(nc -zv ${MYSQL_SERVER_ADDRESS} ${MYSQL_SERVER_PORT}; echo $?) -ne 0 ]]; then
  echo "${MYSQL_SERVER_ADDRESS} mysql server is not reachable on port ${MYSQL_SERVER_PORT}"
  exit 1
fi

# netcat test trackmania
if [[ $(nc -zv ${MANIAPLANET_SERVER_ADDRESS} ${MANIAPLANET_XMLRPC_PORT}; echo $?) -ne 0 ]]; then
 echo "${MANIAPLANET_SERVER_ADDRESS} trackmania server is not reachable on port ${MANIAPLANET_XMLRPC_PORT}"
 exit 1
fi

php /maniacontrol/ManiaControl.php 2>&1
