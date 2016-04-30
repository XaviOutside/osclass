#!/bin/bash

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php/php.ini

sed -i 's#DocumentRoot "/var/www/localhost/htdocs"#DocumentRoot "/var/www/html"#' /etc/apache2/httpd.conf 
sed -i 's#<Directory "/var/www/localhost/htdocs">#<Directory "/var/www/html">#' /etc/apache2/httpd.conf             

echo "=> Setting up the html directory..."
chmod a+w /var/www/html/oc-content/uploads/
chmod a+w /var/www/html/oc-content/downloads/
chmod a+w /var/www/html/oc-content/languages/
chmod a+w /var/www/html/
chown -R apache.apache /var/www/html
ln -sf /usr/lib /var/www/lib
echo "=> Done!"

mkdir -p /run/apache2
mkdir -p /var/log/supervisord

supervisord -n -c /etc/supervisord.conf 

