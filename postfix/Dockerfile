FROM alpine

MAINTAINER XaviOutside https://github.com/XaviOutside/MIGRATION_OSCLASS_2_DOCKER

# Install packages
RUN apk update && \
    apk add bash postfix rsyslog

ADD run.sh /run.sh

EXPOSE 25 

CMD ["/run.sh"]

