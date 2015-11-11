# docker-postfix

FROM ubuntu:14.04

Installs:
 - postfix
 - libsasl

Allows customizing installation using running ENV:
 - postfix:
    - MY_DESTINATION: mydestination in /etc/postfix/main.cf
    - RELAY_SERVER: relayhost in /etc/postfix/main.cf
    - TLS: smtp_tls_security_level in /etc/postfix/main.cf
 - /etc/mailname
    - MAIL_NAME
 - /etc/postfix/sasl_passwd
    - CREDENTIALS: contents of the file that is then processed by "postmap /etc/postfix/sasl_passwd"

```
docker -e MAIL_NAME=... \
       -e TLS=encrypt \
       -e MY_DESTINATION=... \
       -e RELAY_SERVER=... \
       -e CREDENTIALS=... \
       -d packagepeer/postfix:1
```
