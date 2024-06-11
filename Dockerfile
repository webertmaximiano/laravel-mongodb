ARG PHP_VERSION=8.3

FROM php:${PHP_VERSION}-cli

# Install extensions
RUN apt-get update && \
    apt-get install -y autoconf pkg-config libssl-dev git unzip libzip-dev zlib1g-dev && \
    pecl install mongodb && docker-php-ext-enable mongodb && \
    pecl install xdebug && docker-php-ext-enable xdebug && \
    docker-php-ext-install -j$(nproc) zip

# Create php.ini
RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
