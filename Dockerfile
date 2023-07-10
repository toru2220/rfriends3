FROM    ubuntu:22.04

WORKDIR /app

RUN     apt-get update && apt-get install -y wget && \
        wget http://rfriends.s1009.xrea.com/files3/rfriends3_ubuntu.sh

RUN     ls -l && sh rfriends3_ubuntu.sh && \
        ls -l /app

# ENTRYPOINT [ "sh", "rfriends3/rfriends3_server.sh" ]
