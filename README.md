# MIGRATION_OSCLASS_2_DOCKER

This readme file will guide you through the process of migrating an Osclass installation to a Docker infrastructure.

The infrastructure consists of six Docker containers: Three server containers and three volume containers.

  1. Mysql database
  2. Postfix server
  3. Apache2 Webserver
  4. Osclass volume
  5. Database volume
  6. Backup volume

PREREQUISITES:

1. Install VirtualBox
2. Install Docker, Docker-machine and Docker-compose (refer to Docker documentation for different distros)

**Note:**
Tested on Osclass 3.5.

STEPS:

1. Create the virtualbox machine.

     $ docker-machine create --driver virtualbox dockerenv 

     $ docker-machine active dockerenv

     $ $(docker-machine env dockerenv)

2. Download scripts and cd to folder.

     $ git clone https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER.git

3. Replace files from migrate folder with the prerequisites migrate files.

     a. backup_osclass.tar.gz for osclass files.

     b. backup.mysql.sql for database dump file.

5. Modify variables in common.env file in order to customize your domain and password.

     $ vi common.env 

       # Set of variables;

       DOMAIN=yourdomain.org

       MYSQL_ROOT_PASSWORD=yourpassword

6. Build containers.

     $ docker-compose build

7. Run containers.

     $ docker-compose up

8. Launch the following url in your favorite browse.

     **Note:**
     You can get your ip with the following command:

     $ docker-machine ip
     
     http://your_ip_docker_machine

IMPORT DATA:

1. Create a tar.gz of your current osclass server and replace the backup_osclass.tar.gz that you can find in the folder "migration".
     
2. Create a dump file of your osclass database and replace the backup.mysql.sql that you can find in the folder "migration".
     
3. We are going to copy the migration folder into the osclass container.

     $ tar -cf - migration | docker exec -i <NAME_OSCLASS_CONTAINER>  /bin/tar -C / -xf -

4. Now we are ready to run the osclass_init.sh script in order to import the files and database data into our volume containers.

     $ docker exec -it <NAME_OSCLASS_CONTAINER> bash /osclass_init.sh

BACKUPS:

1. Generate a backup of our osclass files and database.

     $ docker exec -it <NAME_OSCLASS_CONTAINER> bash /osclass_backup.sh

OTHERS:

There is an INSTALL.sh file if you want to launch without docker-compose.
