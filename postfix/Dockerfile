FROM ubuntu:trusty

MAINTAINER XaviOutside https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER

# Install packages
RUN apt-get update && \
  apt-get -y install postfix mailutils rsyslog

ADD run.sh /run.sh

EXPOSE 25 

CMD ["/run.sh"]
