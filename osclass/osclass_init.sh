#!/bin/bash

# We gonna add the osclass files to the container
rm -rf /var/www/html/* 
cp /migration/backup_osclass.tar.gz /var/www/html/backup_osclass.tar.gz
cd /var/www/html && tar -xvf backup_osclass.tar.gz && rm -f /var/www/html/backup_osclass.tar.gz

OSCLASS_DB_NAME=$(grep "DB_NAME" /var/www/html/config.php | awk -F"'" '{print $4}')
OSCLASS_USER_NAME=$(grep "DB_USER" /var/www/html/config.php | awk -F"'" '{print $4}')
OSCLASS_PASSWD=$(grep "DB_PASSWORD" /var/www/html/config.php | awk -F"'" '{print $4}')

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -p${MYSQL_ENV_MYSQL_ROOT_PASSWORD} -h mysql -e "status" > /dev/null 2>&1
    RET=$?
done

echo "=> Creating MySQL osclassdb database $OSCLASS_DB_NAME with user $OSCLASS_USER_NAME and password $OSCLASS_PASSWD"
mysql -uroot -p${MYSQL_ENV_MYSQL_ROOT_PASSWORD} -h mysql -e "CREATE DATABASE $OSCLASS_DB_NAME DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
mysql -uroot -p${MYSQL_ENV_MYSQL_ROOT_PASSWORD} -h mysql -e "CREATE USER $OSCLASS_USER_NAME@'%' IDENTIFIED BY '$OSCLASS_PASSWD'"
mysql -uroot -p${MYSQL_ENV_MYSQL_ROOT_PASSWORD} -h mysql -e "GRANT ALL PRIVILEGES ON $OSCLASS_DB_NAME.* TO $OSCLASS_USER_NAME@'%' WITH GRANT OPTION"
sed -i "s/define('DB_HOST', 'localhost');/define('DB_HOST', 'mysql');/" /var/www/html/config.php 
echo "=> Done!"

echo "=> Importing data."
mysql -u$OSCLASS_USER_NAME -p${MYSQL_ENV_MYSQL_ROOT_PASSWORD} -h mysql -p$OSCLASS_PASSWD $OSCLASS_DB_NAME < /migration/backup.mysql.sql
echo "=> Done!"
