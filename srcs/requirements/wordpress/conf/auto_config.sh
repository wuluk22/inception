#!/bin/sh

# Adjust ownership of the directory
chown -R www-data:www-data /var/www/wordpress/

# Move wp-config.php if it doesn't already exist
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    mv /tmp/wp-config.php /var/www/wordpress/
fi

# Wait for the database to be ready
echo "Waiting for database to be ready..."
sleep 10

# Download WordPress core files if not already present
if [ ! -d "/var/www/wordpress/wp-includes" ]; then
    echo "Downloading WordPress core..."
    wp --allow-root --path="/var/www/wordpress/" core download
fi

# Install WordPress if not already installed
if ! wp --allow-root --path="/var/www/wordpress/" core is-installed; then
    echo "Installing WordPress..."
    wp --allow-root --path="/var/www/wordpress/" core install \
        --url="${WORDPRESS_URL}" \
        --title="${WORDPRESS_TITLE}" \
        --admin_user="${WORDPRESS_ADMIN_USER}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}"
fi

# Create a new user if it doesn't exist
if ! wp --allow-root --path="/var/www/wordpress/" user get "${WORDPRESS_USER}" >/dev/null 2>&1; then
    echo "Creating new WordPress user..."
    wp --allow-root --path="/var/www/wordpress/" user create \
        "${WORDPRESS_USER}" \
        "${WORDPRESS_EMAIL}" \
        --user_pass="${WORDPRESS_PASSWORD}" \
        --role="${WORDPRESS_ROLE}"
fi

# Start PHP-FPM
exec "$@"

