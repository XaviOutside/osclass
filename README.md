# MIGRATION_OSCLASS_2_DOCKER
How to migrate current Osclass installation to docker infrastructure.
The infrastructure consist of three Docker containers. One Mysql database container, one Postfix server in order to receive emails on a domain and the last one runs Apache2/PHP Application.

Prerequisites:

1. Install docker (refer to docker documentation for different distros)
2. Create a Osclass backup.
3. Create a database backup.

Steps:

1. Download scripts:

     # git clone https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER.git

2. Replace Osclass backup (backup_osclass.tar.gz) in osclass directory.

3. Replace Database backup (backup.mysql.sql) in osclass directory.

4. Modify variables from INSTALL.sh in order to customize your domain and password.

5. Execute installation script:

     # sh INSTALL.sh

6. Open web browser in the url: http://your_ip_docker_machine
