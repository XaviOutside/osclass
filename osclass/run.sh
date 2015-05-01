#!/bin/bash

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini

bash /osclass_init.sh

# I don't know why but it seems that they don't get the permission
mv /var/www/html /var/www/html.old && mv /var/www/html.old /var/www/html

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
