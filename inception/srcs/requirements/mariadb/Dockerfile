FROM alpine:3.20.5

ENV SQL_DATABASE=mydb \
	SQL_USER=myuser \
	SQL_PASSWORD=mypassword \
	SQL_ROOT_PASSWORD=rootpassword

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client openrc

RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY scripts/init-db.sh /init-db.sh
RUN chmod +x /init-db.sh

EXPOSE 3306

CMD ["/bin/sh", "-c", "/init-db.sh && exec mysqld_safe"]

