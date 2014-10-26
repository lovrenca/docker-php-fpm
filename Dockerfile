#Required params
FROM debian
MAINTAINER Lovrenc Avsenek <a.lovrenc@gmail.com>

# Instaling package and clean up the mess
RUN apt-get update --yes && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -y install \
        php5 \
        php5-cli \
        php5-common \
        php5-curl \
        php5-fpm \
        php5-gd \
        php5-gmp \
        php5-imagick \
        php5-intl \
        php5-json \
        php5-mcrypt \
        php5-memcache \
        php5-pgsql \
        php5-mysql \
        php5-sqlite && \
    apt-get clean

RUN php5enmod mcrypt

# Edit config files.
RUN sed -i '/^listen =/clisten = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf; \
    sed -i '/^upload_max_filesize /cupload_max_filesize = 2000m' /etc/php5/fpm/php.ini; \
    sed -i '/^post_max_size /cpost_max_size  = 2000m' /etc/php5/fpm/php.ini

#Port config
EXPOSE 9000

#Run!
CMD php5-fpm -F -y /etc/php5/fpm/php-fpm.conf -c /etc/php5/fpm/php.ini
