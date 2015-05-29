# docker-postfix

FROM ubuntu:14.04

Installs:
 - postfix
 - libsasl

Allows customizing installation using running ENV:
 - postfix:
 -- HOSTNAME: myhostname in /etc/postfix/main.cf
 -- MY_DESTINATION: mydestination in /etc/postfix/main.cf
 -- RELAY_SERVER: relayhost in /etc/postfix/main.cf
 - /etc/mailname
 -- MY_DESTINATION
 - /etc/postfix/sasl_passwd
 -- CREDENTIALS: contents of the file that is then processed by "postmap /etc/postfix/sasl_passwd"

```
docker -e HOSTNAME=... \
       -e MY_DESTINATION=... \
       -e RELAY_SERVER=... \
       -e CREDENTIALS=... \
       -d packagepeer/postfix:1
```
