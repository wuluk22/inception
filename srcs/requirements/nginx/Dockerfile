# Step 1: Start with the base Debian image
FROM debian:bullseye-slim

# Step 2: Set non-interactive mode for APT to avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Step 3: Update package list and install NGINX, OpenSSL, and utilities
RUN apt-get update && \
    apt-get install -y nginx openssl vim curl && \
    rm -rf /var/lib/apt/lists/*

# Step 4: Create directories for SSL certificates and NGINX runtime files
RUN mkdir -p /etc/nginx/ssl /var/run/nginx

# Step 5: Generate SSL certificate and key (self-signed)
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"


# Step 6: Copy the custom NGINX configuration file into the container
COPY conf/fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

# Step 8: Set the default command to run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]

