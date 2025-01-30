FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and PHP (using deb.sury.org for PHP versions)
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget vim lsb-release apt-transport-https ca-certificates curl && \
    curl -sSL https://packages.sury.org/php/README.txt | bash - && \
    apt-get install -y php7.3 php7.3-fpm php7.3-mysql php7.3-xml php7.3-curl php7.3-gd php7.3-mbstring && \
    rm -rf /var/lib/apt/lists/*

# Ensure the /run/php directory exists
RUN mkdir -p /run/php

# Install WordPress
RUN wget https://wordpress.org/latest.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf latest.tar.gz && \
    rm latest.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress

# Copy configuration files (wp-config.php, PHP config adjustments)
COPY conf/wp-config.php /tmp/
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh

# Install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Set script permissions
RUN chmod +x /usr/local/bin/auto_config.sh

# Expose PHP-FPM port
EXPOSE 9000

# Use the script as the entrypoint
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

# Default CMD to keep PHP-FPM running
CMD ["/usr/sbin/php-fpm7.3", "-F"]

