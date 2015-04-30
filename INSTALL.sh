#!/bin/bash

character_loop() {
 for i in $(seq 1 $(echo $1 | wc -c))
  do
   printf "=";
 done;
}

print_banner() {
 printf "\n";
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

print_banner "DOWNLOADING MYSQL SETUP FILES FROM DOCKER LIBRARY (https://registry.hub.docker.com/u/library/mysql/)...[starting]"
git clone https://github.com/docker-library/mysql.git
print_banner "DOWNLOADING MYSQL SETUP FILES FROM DOCKER LIBRARY...[completed]"

print_banner "CREATING MYSQL CONTAINER...[starting]"
cd ${TOPDIR}/mysql/5.6 && docker build --force-rm --rm -t mysql5.6 .
print_banner "CREATING MYSQL CONTAINER...[completed]"

