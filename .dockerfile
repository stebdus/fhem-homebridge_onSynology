FROM debian
MAINTAINER Stefan Ebener <email@stefan-ebener.com>

##################################################
# Set environment variables                      #
##################################################

# ENV DEBIAN_FRONTEND noninteractive
# ENV TERM xterm

##################################################
# Install tools                                  #
##################################################

RUN apt-get update
RUN apt-get upgrade
RUN apt-get install -y apt-utils 
RUN apt-get install -y curl wget git python build-essential make g++ libavahi-compat-libdnssd-dev libkrb5-dev vim net-tools nano
RUN alias ll='ls -alG'

##################################################
# Install homebridge                             #
##################################################

RUN npm install -g homebridge --unsafe-perm

# depending on your config.json you have to add your modules here!
RUN npm install -g homebridge-fhem --unsafe-perm
#RUN npm install -g homebridge-philipshue --unsafe-perm

##################################################
# Start                                          #
##################################################

USER root
RUN mkdir -p /var/run/dbus

ADD image/run.sh /root/run.sh

EXPOSE 5353 51826
CMD ["/root/run.sh"]
