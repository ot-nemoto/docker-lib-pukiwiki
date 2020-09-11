FROM centos:centos5.11

COPY config/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum update -y && \
    yum install -y --enablerepo=centosplus openssl-devel && \
    yum install -y httpd httpd-devel php-devel php-mysql php-mbstring php-gd \
                   sendmail sendmail-cf sendmail-devel mailx make

WORKDIR /root

COPY pukiwiki-1.4.7_notb.tar.gz /root/pukiwiki-1.4.7_notb.tar.gz
RUN tar -zxvf pukiwiki-1.4.7_notb.tar.gz -C /var/www/html && \
    ln -s pukiwiki-1.4.7_notb /var/www/html/wiki && \
    chown -R $(id -u apache):$(id -g apache) /var/www/html/wiki/

COPY config/basic-auth.conf /etc/httpd/conf.d/basic-auth.conf
COPY config/redirect.conf /etc/httpd/conf.d/redirect.conf

RUN ln -sf  /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    touch /var/www/html/healthcheck.html

COPY config/access-log.conf /etc/httpd/conf.d/access-log.conf
RUN sed -i -e "s/^CustomLog/#CustomLog/g" /etc/httpd/conf/httpd.conf

COPY startup.sh startup.sh
RUN chmod +x startup.sh

EXPOSE 80

CMD ["./startup.sh"]
