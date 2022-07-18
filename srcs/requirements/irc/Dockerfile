# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/
LABEL   org.opencontainers.image.version=0.1.0 

# copy ssh key from host
COPY     ~/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
COPY     ~/.ssh/id_rsa /root/.ssh/id_rsa

# install dependencies 
RUN     apk update && apk upgrade && apk add --update --no-cache \
            build-base \
            make \
            git \
            wireshark \
 &&     rm -f /var/cache/apk/* \

# create dest folder for irc server source files
 &&     mkdir /var/irc \

# modify ssh keys rights
 &&     chmod 600 /root/.ssh/id_rsa \
 &&     chmod 600 /root/.ssh/id_rsa.pub \

# clone server project from github
 &&     git clone ${REPO} /var/irc \

# create server bin and move it to /usr/bin
 &&     cd /var/irc \
 &&     make \
 &&     mv ./test /usr/bin/irc_server \
 &&     chmod +x /usr/bin/irc_server

EXPOSE  6667

CMD     ["irc_server"]