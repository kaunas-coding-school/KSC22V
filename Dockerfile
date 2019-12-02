FROM php:7.2-fpm

# Upgrade packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    unzip \
    gnupg \
    libfreetype6-dev \
    libmcrypt-dev \
    curl \
    libcurl4-gnutls-dev \
    libxml2 \
    libxml2-dev \
    libicu-dev

# Install and configure php extensions
RUN docker-php-ext-configure hash --with-mhash \
    && docker-php-ext-install -j$(nproc) \
        iconv \
        bcmath \
        curl \
        mbstring \
        hash \
        pdo \
        pdo_mysql \
        soap \
        intl \
        sockets \
        zip \
        gd \
    && pecl install \
        mcrypt-1.0.1 \
    && docker-php-ext-enable \
        mcrypt \
        opcache

# Copy sources
COPY --chown=www-data:www-data . /var/www

WORKDIR /var/www

RUN chmod -R a+w /var/www
RUN chown -R www-data:www-data /var/www

RUN ls -la /var/www

COPY docker-php-entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-php-entrypoint"]
# Start php-fpm
EXPOSE 9000
CMD ["php-fpm"]
