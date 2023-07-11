FROM    ghcr.io/iqustech/docker-images/php-base:main

WORKDIR /app

RUN     apt-get update && apt-get install -y unzip at nano vim wget curl atomicparsley ffmpeg
RUN     wget http://rfriends.s1009.xrea.com/files3/rfriends3_latest_script.zip && \
        unzip -q -o rfriends3_latest_script.zip

EXPOSE  8000

COPY    startup.sh .
ENTRYPOINT [ "sh", "startup.sh" ]
