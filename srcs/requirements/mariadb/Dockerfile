# Use the Debian image and install MariaDB
FROM debian:bullseye-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apt-utils && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

# Copy the configuration files (if any)
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

COPY scripts/init-db.sh /usr/local/bin/init-db.sh
RUN mkdir -p /run/mysqld
RUN chown mysql:mysql /run/mysqld
RUN chmod +x /usr/local/bin/init-db.sh

EXPOSE 3306

# Run the MariaDB service
CMD ["mysqld"]

