#!/bin/bash

cat << EOF > /etc/postfix/virtual
@DOMAIN	root
EOF

postconf -e myhostname=$DOMAIN
postconf -e mydestination=$DOMAIN
postconf -e virtual_alias_maps=hash:/etc/postfix/virtual
postmap /etc/postfix/virtual

service rsyslog start
service postfix start
tail -F /var/log/mail.log
