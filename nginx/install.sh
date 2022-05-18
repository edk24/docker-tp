#!/bin/bash
yum -y install gcc gcc-c++ 
yum -y install pcre pcre-devel 
yum -y install zlib zlib-devel 
yum -y install openssl openssl-devel

tar -zxvf ./nginx-1.20.2.tar.gz && cd nginx-1.20.2 && ./configure --prefix=/usr/local/nginx && make -j 8 && make install && echo export PATH=$PATH:/usr/local/nginx/sbin/ >> /etc/profile.d/nginx.sh && source /etc/profile.d/nginx.sh 