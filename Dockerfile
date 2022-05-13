FROM centos:7
LABEL org.opencontainers.image.authors = "yuxiaobo"

WORKDIR /root/

# DNS
COPY ./config/resolv.conf /etc/resolv.conf

# 安装包
COPY ./php /root/php-source
COPY ./nginx /root/nginx-source

# NGINX || php73
RUN cd ~/nginx-source && chmod +x ./install.sh && sh ./install.sh && cd ~/php-source && chmod +x ./install.sh && ./install.sh && yum clean all && rm -rf ~/nginx-source &&  rm -rf ~/php-source

VOLUME [ "/data" ]
EXPOSE 80 443