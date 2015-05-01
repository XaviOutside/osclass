# MIGRATION_OSCLASS_2_DOCKER
How to migrate current Osclass installation to docker infrastructure.
The infrastructure consist of two Docker containers. One Mysql database container and another about Apache2/PHP Application.

Prerequisites:

1. Install docker (refer to docker documentation for different distros)
2. Create a Osclass backup.
3. Create a database backup.

Steps:

1. Download scripts:

     # git clone https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER.git

2. Replace Osclass backup (backup_osclass.tar.gz) in osclass directory.

3. Replace Database backup (backup.mysql.sql) in osclass directory.

4. Execute installation script:

     # sh INSTALL.sh

5. Open web browser in the url: http://your_ip_docker_machine
