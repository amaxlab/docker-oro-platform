FROM centos:7

MAINTAINER "Egor Zyuskin" <e.zyuskin@tree-soft.com>

ADD ./etc/yum.repos.d/ /etc/yum.repos.d/

RUN rpm -i http://mirror.yandex.ru/epel/7Server/x86_64/e/epel-release-7-9.noarch.rpm && \
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

RUN yum install -y php56w php56w-gd php56w-intl php56w-mbstring php56w-mcrypt php56w-pgsql php56w-fpm supervisor nginx git

RUN yum clean all && \
    rm -f -R /var/www/html /var/www/cgi-bin

ADD ./etc/ /etc/
ADD ./usr/ /usr/
ADD ./var/ /var/

WORKDIR /var/www

EXPOSE 80 9001

ENTRYPOINT ["/usr/bin/supervisord"]