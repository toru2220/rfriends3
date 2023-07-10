# FROM    php:zts-bullseye

# WORKDIR /app

# RUN     apt-get update && apt-get install -y unzip at nano vim wget curl atomicparsley ffmpeg
# # RUN     apt-get update && apt-get install -y php-cli php-xml php-zip php-mbstring php-json php-curl php-intl dnsutils iproute2
# RUN     wget http://rfriends.s1009.xrea.com/files3/rfriends3_latest_script.zip && \
#         unzip -q -o rfriends3_latest_script.zip

# ENTRYPOINT [ "sh", "/app/rfriends3/rfriends3_server.sh" ]

# Dockerfile for rfriends
# 2022/05/25
#
FROM ubuntu:latest

# 文字化け対策
ENV LANG C.UTF-8
ENV LANGUAGE en_US

# タイムゾーン設定
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# sudo,cron tzdataのinstall
RUN apt-get update && apt-get install -y sudo cron tzdata

# ユーザradioをsudoユーザに設定

ARG USERNAME=radio
ARG GROUPNAME=radio
ARG PASSWORD=radio

# ホストのUID,GIDに合わせる
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME/

# rfriends用アプリのインストール
RUN sudo apt-get install -y wget unzip at nano vim \
                 atomicparsley pulseaudio dnsutils ffmpeg \
                 php-cli php-xml php-zip php-mbstring

# rfriendsのダウンロードと展開(ホスト共有しないとき用)
run wget http://rfriends.s1009.xrea.com/files/rfriends2_latest_script.zip && \
    unzip rfriends2_latest_script.zip

# rfriendsの実行（非推奨）
# CMD ["sh","/home/radio/rfriends2/rfriends2.sh"]

CMD ["/bin/bash"]
