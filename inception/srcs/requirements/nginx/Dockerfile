FROM alpine:3.20.5
RUN apk update
RUN apk upgrade
RUN apk add nginx
RUN apk add vim
RUN apk add curl
RUN apk add openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN mkdir -p /var/run/nginx
RUN mkdir -p /var/www/html

RUN adduser -D -g 'www' www
RUN chmod 755 /var/www/html
RUN chown -R www:www /var/www/html

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
