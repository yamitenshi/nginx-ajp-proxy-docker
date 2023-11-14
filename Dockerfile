FROM alpine:3 AS build

RUN apk add --update --no-cache wget tar git openssl-dev pcre-dev zlib-dev build-base && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget http://nginx.org/download/nginx-1.21.3.tar.gz && \
    tar -xvzf nginx-1.21.3.tar.gz && \
    git clone https://github.com/dvershinin/nginx_ajp_module.git && \
    cd nginx-1.21.3 && \
    ./configure --add-module=/tmp/src/nginx_ajp_module --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules && \
    make && \
    make install



FROM alpine:3 AS nginx_ajp

RUN apk add --update --no-cache openssl pcre zlib envsubst
RUN mkdir -p /etc/nginx/conf && \
    mkdir -p /etc/nginx/logs
COPY --from=build /usr/sbin/nginx /usr/sbin/nginx
COPY nginx.conf /etc/nginx/conf/nginx.conf.template
COPY --chmod=744 entrypoint.sh /bin/entrypoint.sh

EXPOSE 80


ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
