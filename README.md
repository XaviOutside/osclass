# MIGRATION_OSCLASS_2_DOCKER
How to migrate current Osclass installation to docker infrastructure.
The infrastructure consist of three Docker containers and three Docker volume containers. One Mysql database container, one Postfix server in order to receive emails on a domain and the last one runs Apache2/PHP Application. And the volumes, one for osclass files, one for database and one for backups.

PREREQUISITES:

1. Install docker, docker-machine and docker-compose (refer to docker documentation for different distros)
2. Create a Osclass backup.
3. Create a database backup.

NOTE: Tested on 3.5 Osclass version.

STEPS:

1. Create machine with docker-machine

     # docker-machine create --driver virtualbox dockerenv 
     # docker-machine active dockerenv
     # $(docker-machine env dockerenv)

2. Download scripts and go in to the directory:

     # git clone https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER.git

3. Replace Osclass backup (backup_osclass.tar.gz) in osclass directory.

4. Replace Database backup (backup.mysql.sql) in osclass directory.

5. Modify variables in common.env file in order to customize your domain and password.

6. Build containers:

     # docker-compose build

7. Run containers:

     # docker-compose up

8. Open web browser in the url: http://your_ip_docker_machine

     NOTE: You can know your ip with this command:
     # docker-machine ip

IMPORT DATA:

1. Copy the www backup files into the migration directory.
     
     NOTE: tar.gz format and filename "backup_osclass.tar.gz"
     # cp <PATH>/backup_osclass.tar.gz migration/.

2. Copy the mysql backup dump with the name  
     
     NOTE: tar.gz format and filename "backup.mysql.sql"
     # cp <PATH>/backup.mysql.sql migration/.

3. Copy the files into running container:

     # tar -cf - migration | docker exec -i <NAME_OSCLASS_CONTAINER>  /bin/tar -C / -xf -

4. Execute import script:

     # docker exec -it <NAME_OSCLASS_CONTAINER> bash /osclass_init.sh

BACKUPS:

1. Backup from Osclass files and Database's dump:

     # docker exec -it <NAME_OSCLASS_CONTAINER> bash /osclass_backup.sh

OTHERS:

There is an INSTALL.sh file if you want to launch without docker-compose.
