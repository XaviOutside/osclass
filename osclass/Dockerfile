FROM ubuntu:trusty

MAINTAINER XaviOutside https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER

# Install packages
RUN apt-get update && \
  apt-get -y install supervisor git apache2 libapache2-mod-php5 php5-mysql mysql-client pwgen php-apc php5-mcrypt php5-gd php5-curl

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# We gonna add the osclass files to the container
RUN rm -rf /var/www/html && mkdir -p /var/www/html
COPY backup_osclass.tar.gz /var/www/html/backup_osclass.tar.gz
COPY backup.mysql.sql /backup.mysql.sql
RUN cd /var/www/html && tar -xvf backup_osclass.tar.gz && rm -f /var/www/html/backup_osclass.tar.gz

#Enviornment variables to configure php
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M

ADD run.sh /run.sh
ADD osclass_init.sh /osclass_init.sh

EXPOSE 80 
CMD ["/run.sh"]
