FROM ubuntu:trusty

MAINTAINER XaviOutside https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER

# Install packages
RUN apt-get update && \
  apt-get -y install supervisor git apache2 libapache2-mod-php5 php5-mysql mysql-client pwgen php-apc php5-mcrypt php5-gd php5-curl

# Config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
RUN a2enmod ssl

# Environment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

# Creating volume for html data
VOLUME /var/www/html

ADD run.sh /run.sh
ADD osclass_init.sh /osclass_init.sh
ADD osclass_backup.sh /osclass_backup.sh

EXPOSE 80 
CMD ["/run.sh"]
