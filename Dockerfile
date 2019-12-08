## Composer
FROM composer:latest AS composer

## Base php-fpm
FROM php:fpm

## PHP extensions enabled
ENV PHP_EXTENSIONS ""

## PHP env
ARG PHP_TIMEZONE="UTC"
ARG PHP_UPLOAD_SIZE="100M"

## Supress apt-utils
ARG DEBIAN_FRONTEND=noninteractive

## Install Extensions
RUN set -eux \
    && apt-get update \
# Install dependencies
    && apt-get install -yq --no-install-recommends \
        git zip unzip nfs-common librabbitmq4 libfcgi-bin \
        libpng16-16 libpng-dev libjpeg62-turbo libjpeg62-turbo-dev \
        libzip4 zlib1g libbz2-dev zlib1g-dev libzip-dev \
        libgmp-dev libicu-dev libmcrypt-dev libmemcached-dev  \
        libpq-dev librabbitmq-dev libxml2-dev libfreetype6-dev \
# Install text editor
        nano vim \
# Install PHP extensions from binary
    && docker-php-ext-install \
        bcmath bz2 exif gd gettext gmp intl opcache pcntl \
        soap sockets pdo_pgsql pdo_mysql \
    && apt-get dist-upgrade -y \
# Install PHP extensions using PECL
    && pecl install apcu amqp igbinary memcached mongodb redis xdebug zip \
    && docker-php-ext-enable apcu amqp igbinary memcached mongodb redis xdebug zip \
# Clean up
    && apt-get purge -yq --auto-remove \
        libbz2-dev libgmp-dev libicu-dev libmcrypt-dev \
        librabbitmq-dev libxml2-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
        libmemcached-dev zlib1g-dev libzip-dev \
    && apt-get clean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Set PHP config
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i "s/;date.timezone =.*/date.timezone = ${PHP_TIMEZONE}/" /usr/local/etc/php/php.ini \
    && sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /usr/local/etc/php/php.ini \
    && sed -i "s/upload_max_filesize =.*/upload_max_filesize = ${PHP_UPLOAD_SIZE}/" /usr/local/etc/php/php.ini \
    && sed -i "s/post_max_size =.*/post_max_size = ${PHP_UPLOAD_SIZE}/" /usr/local/etc/php/php.ini \
# Disable additional extensions
    && mkdir -p /usr/local/etc/php/extensions \
    && mv /usr/local/etc/php/conf.d/*.ini /usr/local/etc/php/extensions/

# Install Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Enable zip extension for composer
RUN if [ ! -e /usr/local/etc/php/conf.d/docker-php-ext-zip.ini ]; then mv /usr/local/etc/php/extensions/docker-php-ext-zip.ini /usr/local/etc/php/conf.d/docker-php-ext-zip.ini; fi;
# Require prestissimo for speed
RUN composer global require hirak/prestissimo --no-interaction --no-progress

# Install Laravel and Laravel Envoy
RUN composer global require laravel/installer laravel/envoy --no-interaction --no-progress 