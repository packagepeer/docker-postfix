#!/bin/bash

/etc/init.d/postfix stop
kill $(ps -fea | grep "/usr/lib/postfix/master" | grep -v grep | awk '{print $2}') || true


echo "${CREDENTIALS}" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
rm /etc/postfix/sasl_passwd


sed -i "s/%%%MY_DESTINATION%%%/${MY_DESTINATION}/g" /etc/mailname


sed -i "s/%%%HOSTNAME%%%/$(hostname)/g" /etc/postfix/main.cf
sed -i "s/%%%MY_DESTINATION%%%/${MY_DESTINATION}/g" /etc/postfix/main.cf
sed -i "s/%%%RELAY_SERVER%%%/${RELAY_SERVER}/g" /etc/postfix/main.cf



/etc/init.d/rsyslog start
/etc/init.d/postfix start

tail -f /var/log/syslog | grep postfix
