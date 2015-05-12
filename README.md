# MIGRATION_OSCLASS_2_DOCKER
How to migrate current Osclass installation to docker infrastructure.
The infrastructure consist of three Docker containers. One Mysql database container, one Postfix server in order to receive emails on a domain and the last one runs Apache2/PHP Application.

Prerequisites:

1. Install docker (refer to docker documentation for different distros)
2. Create a Osclass backup.
3. Create a database backup.

NOTE: Tested on 3.5.6 Osclass version.

Steps:

1. Download scripts:

     # git clone https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER.git

2. Replace Osclass backup (backup_osclass.tar.gz) in osclass directory.

3. Replace Database backup (backup.mysql.sql) in osclass directory.

4. Modify variables from INSTALL.sh in order to customize your domain and password.

5. Execute installation script:

     # sh INSTALL.sh

6. Open web browser in the url: http://your_ip_docker_machine

Import data:

1. Create new directory in your host machine.
  
     # mkdir migration

2. Copy the www backup files into the migration directory.
     
     IMPORTANT: tar.gz format and filename "backup_osclass.tar.gz"
     # cp <PATH>/backup_osclass.tar.gz migration/.

3. Copy the mysql backup dump with the name  
     
     IMPORTANT: tar.gz format and filename "backup.mysql.sql"
     # cp <PATH>/backup.mysql.sql migration/.

4. Copy the files into running container:

     # tar -cf - migration | docker exec -i osclass /bin/tar -C / -xf -

5. Execute import script:

     # docker exec -it osclass bash /osclass_init.sh

Backups:

1. Backup from Osclass files and Database's dump:

     # docker exec -it osclass bash /osclass_backup.sh
