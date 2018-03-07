FROM centos:7
MAINTAINER Stalin Pereira, letter2stalin@gmail.com

ENV KONG_VERSION 0.12.2

RUN yum install -y git wget https://bintray.com/kong/kong-community-edition-rpm/download_file?file_path=centos/7/kong-community-edition-$KONG_VERSION.el7.noarch.rpm && \
    yum clean all

RUN git clone https://github.com/wshirey/kong-plugin-response-cache.git kong-plugin-response-cache

RUN cd kong-plugin-response-cache && luarocks make --verbose

COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-c", "/usr/local/kong/nginx.conf", "-p", "/usr/local/kong/"]
