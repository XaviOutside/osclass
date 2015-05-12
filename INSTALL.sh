#!/bin/bash

character_loop() {
 for i in $(seq 1 $(echo $1 | wc -c))
  do
   printf "=";
 done;
}

print_banner() {
 character_loop "$1";
 printf "\n";
 printf "$1\n";
 character_loop "$1";
 printf "\n";
}

print_banner "CREATING WORK DIRECTORY...[starting]";
TOPDIR=$(pwd)
print_banner "CREATING WORK DIRECTORY...[completed]";
sleep 1;

print_banner "CREATING OSCLASS CONTAINER...[starting]"
cd ${TOPDIR}/osclass && docker build -t osclass .
print_banner "CREATING OSCLASS CONTAINER...[completed]"
sleep 1;

print_banner "CREATING POSTFIX CONTAINER...[starting]"
cd ${TOPDIR}/postfix && docker build -t postfix .
print_banner "CREATING POSTFIX CONTAINER...[completed]"
sleep 1;

print_banner "CREATING MYSQL VOLUME CONTAINER...[starting]"
cd ${TOPDIR} && docker create -v /var/lib/mysql --name mysql_volume mysql5.6 /bin/true
print_banner "CREATING MYSQL VOLUME CONTAINER...[completed]"
sleep 1;

print_banner "CREATING OSCLASS VOLUME CONTAINER...[starting]"
cd ${TOPDIR} && docker create -v /var/www/html --name osclass_html_volume osclass /bin/true
print_banner "CREATING OSCLASS VOLUME CONTAINER...[completed]"
sleep 1;

print_banner "CREATING BACKUP VOLUME CONTAINER...[starting]"
cd ${TOPDIR} && docker create -v /backup --name backup_volume osclass /bin/true
print_banner "CREATING BACKUP VOLUME CONTAINER...[completed]"
sleep 1;

print_banner "RUNNING MYSQL CONTAINTER...[starting]"
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456789 --volumes-from mysql_volume --name mysql mysql:5.6
print_banner "RUNNING MYSQL CONTAINTER...[completed]"
sleep 1;

print_banner "RUNNING OSCLASS CONTAINTER...[starting]"
docker run -d -p 80:80 -e DOMAIN=example.org --volumes-from backup_volume --volumes-from osclass_html_volume --name osclass --link mysql:mysql osclass
print_banner "RUNNING OSCLASS CONTAINTER...[completed]"
sleep 1;

print_banner "RUNNING POSTFIX CONTAINTER...[starting]"
docker run -d -p 25:25 -e DOMAIN=example.org --name postfix postfix
print_banner "RUNNING POSTFIX CONTAINTER...[completed]"
