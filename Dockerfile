From ubuntu:trusty
MAINTAINER JAvier Jerónimo <jjeronimo@packageper.com>

# sudo docker -e CREDENTIALS=... -e POSTFIX_ETC_HOSTNAME=... -e POSTFIX_ETC_DESTINATION=... -d packagepeer/postfix

RUN apt-get update && apt-get -yq install postfix libsasl2-modules


ADD etc/mailname /etc/mailname
ADD etc/postfix/main.cf /etc/postfix/main.cf


ADD pkgp-run.sh /pkgp-run.sh
RUN chmod u+x /pkgp-run.sh

EXPOSE 25

# ################################################################################ Entry point
# From tutum/tomcat:7.0
CMD ["/pkgp-run.sh"]
