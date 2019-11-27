#################################
## Dockerfile ManiaControl     ##
## Imperium                    ##
#################################

# Get SIMTIO template image
FROM simtio/base_image:latest

# Setup author
MAINTAINER Alban E.G.

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

# Add filese
COPY entrypoint.sh /

# Install packages
RUN curl -s --retry 5 -L https://packages.sury.org/php/apt.gpg | apt-key add - \
  && echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list \
  && apt-get update \
  && apt-get install --no-install-recommends --no-install-suggests -qy git php7.3 \
    php7.3-cli php7.3-common php7.3-curl php7.3-fpm php7.3-gd  php7.3-json php7.3-mbstring \
    php7.3-mysql php7.3-opcache php7.3-readline php7.3-xml php7.3-xmlrpc php7.3-zip \
  && git clone https://github.com/ManiaControl/ManiaControl.git /maniacontrol \
  && sed -i "s/'LOG_NAME_USE_DATE', true/'LOG_NAME_USE_DATE', false/g" /maniacontrol/ManiaControl.php \
  && sed -i "s/'LOG_NAME_USE_PID', true/'LOG_NAME_USE_PID', false/g" /maniacontrol/ManiaControl.php \
  && chmod +x /entrypoint.sh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  ;

# Volumes
VOLUME /maniacontrol

# Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
