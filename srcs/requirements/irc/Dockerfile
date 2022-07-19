# syntax=docker/dockerfile:1
FROM    alpine:3.15

# build args
ARG     REPO=${REPO}

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/
LABEL   org.opencontainers.image.version=0.1.0 

# install dependencies 
RUN     apk update && apk upgrade && apk add --update --no-cache \
            build-base \
            make \
            git \
            tshark \
            openssh \
 &&     rm -f /var/cache/apk/* \

# permissions for tshark
 &&     chown root:root /usr/bin/dumpcap \

# create ssh folders
 &&     mkdir /root/.ssh/ \
 &&     touch /root/.ssh/known_hosts

# copy keys from host
COPY    conf/id_rsa.pub    /root/.ssh/id_rsa.pub
COPY    conf/id_rsa        /root/.ssh/id_rsa

# add github to known hosts
RUN    ssh-keyscan github.com > /root/.ssh/known_hosts \ 

# create dest folder for irc server source files
 &&     mkdir /irc \

# modify ssh keys rights
 &&     chmod 600 /root/.ssh/id_rsa \
 &&     chmod 644 /root/.ssh/id_rsa.pub \

# clone server project from github
 &&     cd /irc \
 &&     git clone ${REPO} . \

# create server bin and move it to /usr/bin
 &&     make \
 &&     mv ./server /usr/bin/irc_server \
 &&     chmod +x /usr/bin/irc_server

EXPOSE  6667

CMD     ["irc_server"]
