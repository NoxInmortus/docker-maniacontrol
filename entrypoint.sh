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
echo "
<?xml version="1.0" encoding="UTF-8"?>
<maniacontrol>
	<!-- Configure Your ManiaPlanet Server -->
	<server>
		<!-- Server Connection Details -->
		<host>${MANIAPLANET_SERVER_ADDRESS}</host>
		<port>${MANIAPLANET_XMLRPC_PORT}</port>

		<!-- XmlRpc Login Details -->
		<user>${MANIAPLANET_XMLRPC_LOGIN}</user>
		<pass>${MANIAPLANET_XMLRPC_PASSWORD}</pass>
	</server>

	<!-- Configure the MySQL Database used by ManiaControl -->
	<database>
		<!-- MySQL Server -->
		<host>${MYSQL_SERVER_ADDRESS}</host>
		<port>${MYSQL_SERVER_PORT}</port>

		<!-- MySQL User -->
		<user>${MYSQL_USER}</user>
		<pass>${MYSQL_PASSWORD}</pass>

		<!-- Database Name -->
		<name>${MYSQL_DATABASE}</name>
	</database>

	<!-- Configure Server Master-Administrators -->
	<masteradmins>
		<login>${MASTER_ADMIN_USER}</login>
	</masteradmins>
</maniacontrol>" > /maniacontrol/configs/server.xml
fi

# Set trap to stop the script proprely when a docker stop is executed
trap : EXIT TERM KILL INT SIGKILL SIGTERM SIGQUIT

# netcat test mysql
if [[ ! -z $(nc -zv ${MYSQL_SERVER_ADDRESS} ${MYSQL_SERVER_PORT} 2>&1 | grep refused) ]]; then
  echo "${MYSQL_SERVER_ADDRESS} mysql server is not reachable on port ${MYSQL_SERVER_PORT}"
  exit 1
fi

# netcat test trackmania
if [[ ! -z $(nc -zv ${MANIAPLANET_SERVER_ADDRESS} ${MYSQL_SERVER_PORT} 2>&1 | grep refused) ]]; then
  echo "${MANIAPLANET_SERVER_ADDRESS} trackmania server is not reachable on port ${MANIAPLANET_XMLRPC_PORT}"
  exit 1
fi

php /maniacontrol/ManiaControl.php >ManiaControl.log 2>&1
