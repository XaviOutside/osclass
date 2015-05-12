#!/bin/bash

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini

echo "=> Setting up the html directory..."
chmod a+w /var/www/html/oc-content/uploads/
chmod a+w /var/www/html/oc-content/downloads/
chmod a+w /var/www/html/oc-content/languages/
chmod a+w /var/www/html/
chown -R www-data:www-data /var/www/html
echo "=> Done!"

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
