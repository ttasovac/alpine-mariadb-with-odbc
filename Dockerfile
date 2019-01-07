FROM yobasystems/alpine:3.8.1-amd64
LABEL maintainer "Toma Tasovac <ttasovac@humanistika.org>" architecture="AMD64/x86_64"
LABEL mariadb-version="10.2.15" alpine-version="3.8.1" build="03-dec-2018" container-build="$CI_COMMIT_SHA"

RUN apk add --no-cache mariadb mariadb-client pwgen bash nano unixodbc unixodbc-dev && \
    rm -f /var/cache/apk/*

ADD files/run.sh /scripts/run.sh
ADD files/lib/libmaodbc.so /lib/libmaodbc.so
ADD files/etc/odbcinst.ini /etc/odbcinst.ini
RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
