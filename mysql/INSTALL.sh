#!/bin/bash

function character_loop {
 for i in $(seq 1 $(echo $1 | wc -c))
  do
   printf "=";
 done;
}

function print_banner {
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
