FROM alpine

MAINTAINER XaviOutside https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER

# Install packages
RUN apk update && \
    apk add \
            apache2 \
            apache2-ssl \
            bash \
            git \
            mysql-client \
            openrc \
            php5-apache2 \
            php5-apcu \
            php5-cli \ 
            php5-ctype \
            php5-curl \
            php5-gd \
            php5-json \
            php5-mcrypt \
            php5-mysql \
            php5-mysqli \
            php5-opcache \
            php5-openssl \
            php5-pdo \
            php5-pdo_mysql \
            php5-phar \
            pwgen \
            supervisor && \
    rm -f /var/cache/apk/* && \
    sed -i 's"#LoadModule rewrite_module modules/mod_rewrite.so"LoadModule rewrite_module modules/mod_rewrite.so"' /etc/apache2/httpd.conf && \
    sed -i 's"#LoadModule deflate_module modules/mod_deflate.so"LoadModule deflate_module modules/mod_deflate.so"' /etc/apache2/httpd.conf && \
    sed -i 's"#LoadModule setenvif_module modules/mod_setenvif.so"LoadModule setenvif_module modules/mod_setenvif.so"' /etc/apache2/httpd.conf && \
    #sed -i 's"#LoadModule headers_module modules/mod_headers.so"LoadModule headers_module modules/mod_headers.so"' /etc/apache2/httpd.conf && \
    #sed -i 's"#LoadModule ext_filter_module modules/mod_ext_filter.so"LoadModule ext_filter_module modules/mod_ext_filter.so"' /etc/apache2/httpd.conf && \
    #sed -i 's"#LoadModule expires_module modules/mod_expires.so"LoadModule expires_module modules/mod_expires.so"' /etc/apache2/httpd.conf && \
    sed -i 's"#LoadModule logio_module modules/mod_logio.so"LoadModule logio_module modules/mod_logio.so"' /etc/apache2/httpd.conf && \
    sed -i 's"#LoadModule socache_shmcb_module modules/mod_socache_shmcb.so"LoadModule socache_shmcb_module modules/mod_socache_shmcb.so"' /etc/apache2/httpd.conf && \
    sed -i 's"#LoadModule watchdog_module modules/mod_watchdog.so"LoadModule watchdog_module modules/mod_watchdog.so"' /etc/apache2/httpd.conf && \
    echo "Success"

# Config to enable .htaccess
ADD apache_default /etc/apache2/conf.d/nayubiko.conf

# Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

# Creating volume for html data
VOLUME /var/www/html

ADD apache2.ini /etc/supervisor.d/apache2.ini
ADD run.sh /run.sh
ADD osclass_init.sh /osclass_init.sh
ADD osclass_backup.sh /osclass_backup.sh

EXPOSE 80 
CMD ["/run.sh"]

