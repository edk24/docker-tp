#!/bin/bash

# 安装依赖
yum -y install wget gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers gd gd2 gd-devel gd2-devel perl-CPAN pcre-devel

# cmake
cd ~/php-source && tar -zxvf cmake-3.13.2.tar.gz && cd cmake-3.13.2 && ./bootstrap && make && make install

# libzip
cd ~/php-source && tar -zxf libzip-1.5.2.tar.gz && cd libzip-1.5.2 && mkdir build && cd build && cmake .. && make -j4 && make test && make install

# php73
echo '/usr/local/lib64
    /usr/local/lib
    /usr/lib
    /usr/lib64'>>/etc/ld.so.conf && ldconfig -v

cd ~/php-source && tar -zxvf php-7.3.31.tar.gz && cd php-7.3.31  && ./configure \
    --prefix=/usr/local/php73 \
    --exec-prefix=/usr/local/php73 \
    --bindir=/usr/local/php73/bin \
    --sbindir=/usr/local/php73/sbin \
    --includedir=/usr/local/php73/include \
    --libdir=/usr/local/php73/lib/php \
    --mandir=/usr/local/php73/php/man \
    --with-config-file-path=/usr/local/php73/etc \
    --with-mysql-sock=/tmp/mysql.sock \
    --with-mhash \
    --with-openssl \
    --with-mysqli=shared,mysqlnd \
    --with-pdo-mysql=shared,mysqlnd \
    --with-gd \
    --with-iconv \
    --with-zlib \
    --enable-zip \
    --enable-inline-optimization \
    --disable-debug \
    --disable-rpath \
    --enable-shared \
    --enable-xml \
    --enable-bcmath \
    --enable-shmop \
    --enable-sysvsem \
    --enable-mbregex \
    --enable-mbstring \
    --enable-ftp \
    --enable-pcntl \
    --enable-sockets \
    --with-xmlrpc \
    --enable-soap \
    --without-pear \
    --with-gettext \
    --enable-session \
    --with-curl \
    --with-jpeg-dir \
    --with-freetype-dir \
    --enable-opcache \
    --enable-fpm \
    --with-fpm-user=nginx \
    --with-fpm-group=nginx \
    --without-gdbm \
    --enable-fast-install \
    --disable-fileinfo \
    && make && make install \
    && cp php.ini-production /usr/local/php73/etc/php.ini \
    && sed -i 's#;extension_dir = "./"#extension_dir = "/usr/local/php73/lib/php/extensions/no-debug-non-zts-20180731"#g' /usr/local/php73/etc/php.ini \
    && sed -i 's#;date.timezone =#date.timezone = PRC #g' /usr/local/php73/etc/php.ini \
    && echo export PATH=$PATH:/usr/local/php73/bin/:/usr/local/php73/sbin/ >> /etc/profile.d/php.sh \
    && source /etc/profile.d/php.sh 