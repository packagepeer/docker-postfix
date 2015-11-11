#!/bin/bash

echo "[INFO] POSTFIX - Stopping postfix to customize config..."
/etc/init.d/postfix stop

POSTFIX_PID=$(ps -fea | grep "/usr/lib/postfix/master" | grep -v grep | awk '{print $2}')
if [ -n "${POSTFIX_PID}" ]; then
  echo "[WARN] POSTFIX - Postfix still running, killing it: ${POSTFIX_PID}"
  kill ${POSTFIX_PID}
fi

echo "[INFO] POSTFIX - Customizing postfix config..."
sed -i "s/%%%MAIL_NAME%%%/${MAIL_NAME}/g" /etc/mailname

sed -i "s/%%%HOSTNAME%%%/$(hostname)/g" /etc/postfix/main.cf
sed -i "s/%%%MY_DESTINATION%%%/${MY_DESTINATION}/g" /etc/postfix/main.cf
sed -i "s/%%%RELAY_SERVER%%%/${RELAY_SERVER}/g" /etc/postfix/main.cf
sed -i "s/%%%TLS%%%/${TLS}/g" /etc/postfix/main.cf

echo "${CREDENTIALS}" > /etc/postfix/sasl_passwd
postmap /etc/postfix/sasl_passwd
rm /etc/postfix/sasl_passwd

echo "[INFO] POSTFIX - Restarting daemon..."

/etc/init.d/rsyslog start
/etc/init.d/postfix start

echo "[INFO] POSTFIX - Done, postfix logs:"

tail -f /var/log/syslog | grep postfix
