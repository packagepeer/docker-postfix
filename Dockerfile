From ubuntu:14.04
MAINTAINER JAvier Jerónimo <jjeronimo@packageper.com>

# HowTo build: sudo docker build --tag=packagepeer/postfix .
# HowTo run: sudo docker -e POSTFIX_SASL_CREDENTIALS=... -e MY_DESTINATION=... -d packagepeer/postfix

# ################################################################################ Setup
RUN apt-get update && apt-get -yq install postfix libsasl2-modules

ADD etc/mailname /etc/mailname
ADD etc/postfix/main.cf /etc/postfix/main.cf



ADD pkgp-run.sh /pkgp-run.sh
RUN chmod u+x /pkgp-run.sh

EXPOSE 25

# ################################################################################ Entry point
# From tutum/tomcat:7.0
CMD ["/pkgp-run.sh"]
