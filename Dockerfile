FROM debian:sid

COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY entrypoint.sh /entrypoint.sh
ADD heroku-exec.sh /app/.profile.d/heroku-exec.sh
ADD sh-wrapper.sh /bin/sh-wrapper.sh

RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip qrencode curl bash openssh python3\
    && apt install -y shadowsocks-libev\
    && apt autoremove -y\
    && chmod +x /entrypoint.sh\
    && ln -s /usr/bin/python3 /usr/bin/python\
    && chmod +x /app/.profile.d/heroku-exec.sh\
    && chmod +x /bin/sh-wrapper.sh\
    && rm /bin/sh && ln -s /bin/sh-wrapper.sh /bin/sh

CMD /entrypoint.sh
