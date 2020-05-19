#!/bin/bash

echo " => Tar file from /var/www/html..."
cd /var/www/html && tar -zcvf /backup/backup_osclass.tar.gz .
echo " => Done!"

OSCLASS_DBNAME=$(grep "DB_NAME" /var/www/html/config.php | awk -F"'" '{print $4}')
OSCLASS_USERNAME=$(grep "DB_USER" /var/www/html/config.php | awk -F"'" '{print $4}')
OSCLASS_PASSWD=$(grep "DB_PASSWORD" /var/www/html/config.php | awk -F"'" '{print $4}')

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h mysql -e "status" > /dev/null 2>&1
    RET=$?
done

echo " => Dumping database."
mysqldump -h mysql -u ${OSCLASS_USERNAME} -p${OSCLASS_PASSWD} ${OSCLASS_DBNAME} > /backup/backup.mysql.sql
echo " => Done!"
