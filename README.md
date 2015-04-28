# MIGRATION_OSCLASS_2_DOCKER
How to migrate current Osclass installation to docker infrastructure.

Steps:

1. Install docker (refer to docker documentation for different distros)

2. Download docker image:

     # docker pull morfeo8marc/osclass-docker

3. Create directory to store the files of docker:

     # mkdir osclass-docker

4. Download git docker files:

     # git clone https://github.com/morfeo8marc/osclass-docker

5. Modify Dockerfile:

     # docker build --force-rm=true --rm=true -t morfeo8marc/osclass-docker .

6. Export MySQL database:

     # mysqldump -u username -p'password’ dbname > export_database

7. Backup files OSCLASS:

     # cd /home/osclass/public_html/ && tar -cvf osclass_backup.tar .

8. Execute docker:

     # docker run -p 80:80 -it --rm=true --name NAME morfeo8marc/osclass-docker
