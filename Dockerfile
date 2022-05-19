FROM centos:7
LABEL org.opencontainers.image.authors = "yuxiaobo"

WORKDIR /root/

# DNS
COPY ./config/resolv.conf /etc/resolv.conf
# COPY ./config/Centos-7.repo /etc/yum.repos.d/CentOS-Base.repo

# 必要的依赖
# RUN yum -y install wget gcc gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers gd gd2 gd-devel gd2-devel perl-CPAN pcre-devel

# 安装包
COPY ./php /root/php-source
COPY ./nginx /root/nginx-source
# RUN cd ~/nginx-source && tar -zxvf ./nginx-1.20.2.tar.gz && cd nginx-1.20.2 && ./configure --prefix=/usr/local/nginx && make -j 4 && make install && echo "export PATH=$PATH:/usr/local/nginx/sbin" >> /etc/profile.d/nginx.sh && source /etc/profile.d/nginx.sh 
# NGINX || php73
RUN cd ~/nginx-source && chmod +x ./install.sh && sh ./install.sh && rm -rf ~/nginx-source
RUN cd ~/php-source && chmod +x ./install.sh && ./install.sh && rm -rf ~/php-source
RUN yum install -y epel-release && yum install -y certbot python3-certbot-nginx
RUN yum clean all
RUN echo 'export PATH=$PATH:/usr/local/php73/bin/:/usr/local/php73/sbin/:/usr/local/nginx/sbin/' > /etc/profile.d/dockertp.sh && source /etc/profile.d/dockertp.sh
VOLUME [ "/data" ]
EXPOSE 80 443