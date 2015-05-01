#!/bin/bash

OSCLASS_DB_NAME=$(grep "DB_NAME" /var/www/html/config.php | awk -F"'" '{print $4}')
OSCLASS_USER_NAME=$(grep "DB_USER" /var/www/html/config.php | awk -F"'" '{print $4}')
OSCLASS_PASSWD=$(grep "DB_PASSWORD" /var/www/html/config.php | awk -F"'" '{print $4}')

echo "Changing osclass folders permisions"
chmod a+w /var/www/html/oc-content/uploads/
chmod a+w /var/www/html/oc-content/downloads/
chmod a+w /var/www/html/oc-content/languages/
chmod a+w /var/www/html/
echo "=> Done!"

echo "Changing osclass folders ownerships"
chown -R www-data:www-data /var/www/html
echo "=> Done!"

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -p123456789 -h mysql -e "status" > /dev/null 2>&1
    RET=$?
done

echo "=> Creating MySQL osclassdb database $OSCLASS_DB_NAME with user $OSCLASS_USER_NAME and password $OSCLASS_PASSWD"
mysql -uroot -p123456789 -h mysql -e "CREATE DATABASE $OSCLASS_DB_NAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
mysql -uroot -p123456789 -h mysql -e "CREATE USER $OSCLASS_USER_NAME@'%' IDENTIFIED BY '$OSCLASS_PASSWD'"
mysql -uroot -p123456789 -h mysql -e "GRANT ALL PRIVILEGES ON $OSCLASS_DB_NAME.* TO $OSCLASS_USER_NAME@'%' WITH GRANT OPTION"
sed -i "s/define('DB_HOST', 'localhost');/define('DB_HOST', 'mysql');/" /var/www/html/config.php 
echo "=> Done!"

echo "=> Importing data."
mysql -u$OSCLASS_USER_NAME -p123456789 -h mysql -p$OSCLASS_PASSWD $OSCLASS_DB_NAME < /backup.mysql.sql
echo "=> Done!"
