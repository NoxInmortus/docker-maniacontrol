#################################
## Dockerfile ManiaControl     ##
## Imperium                    ##
#################################

# Use official debian image https://hub.docker.com/_/debian/
FROM debian:buster-slim

# Setup author
LABEL maintainer='Alban E.G. (IMPERIUM)'

# Env
ENV MANIAPLANET_SERVER_ADDRESS='' \
    MANIAPLANET_SERVER_PORT='5000' \
    MANIAPLANET_XMLRPC_LOGIN='SuperAdmin' \
    MANIAPLANET_XMLRPC_PASSWORD='' \
    MYSQL_SERVER_ADDRESS='' \
    MYSQL_SERVER_PORT='3306' \
    MYSQL_USER='maniacontrol' \
    MYSQL_PASSWORD='' \
    MYSQL_DATABASE='maniacontrol' \
    MASTER_ADMIN_USER=''

# Add files
COPY entrypoint.sh /

# Install packages
RUN apt-get update && apt-get dist-upgrade -qy \
  && apt-get install --no-install-recommends --no-install-suggests -qy curl netcat openssl ca-certificates gnupg \
  && update-ca-certificates --fresh && curl -sSLk --retry 5 https://packages.sury.org/php/apt.gpg | apt-key add - \
  && echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -qy git php7.2 \
    php7.2-cli php7.2-common php7.2-curl php7.2-fpm php7.2-gd  php7.2-json php7.2-mbstring \
    php7.2-mysql php7.2-opcache php7.2-readline php7.2-xml php7.2-xmlrpc php7.2-zip \
  && git clone https://github.com/ManiaControl/ManiaControl.git /maniacontrol \
  && sed -i "s/'LOG_NAME_USE_DATE', true/'LOG_NAME_USE_DATE', false/g" /maniacontrol/ManiaControl.php \
  && sed -i "s/'LOG_NAME_USE_PID', true/'LOG_NAME_USE_PID', false/g" /maniacontrol/ManiaControl.php \
  && chmod +x /entrypoint.sh \
  && apt-get remove --purge -qy git curl \
  && apt-get clean \
  && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* \
  ;

# Volumes
VOLUME /maniacontrol

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
