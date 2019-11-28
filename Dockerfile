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
        redis-3.1.3 \
        mcrypt-1.0.1 \
    && docker-php-ext-enable \
        redis \
        mcrypt \
        opcache

COPY ./php.ini /usr/local/etc/php/

COPY ./memory-limit-php.ini /usr/local/etc/php/conf.d/memory-limit-php.ini

RUN sed -ie s/pm.max_children\ =\ 5/pm.max_children\ =\ 200/ /usr/local/etc/php-fpm.d/www.conf &&\
    sed -ie s/pm.start_servers\ =.*/pm.start_servers\ =\ 100/ /usr/local/etc/php-fpm.d/www.conf &&\
    sed -ie s/pm.min_spare_servers\ =.*/pm.min_spare_servers\ =\ 50/ /usr/local/etc/php-fpm.d/www.conf &&\
    sed -ie s/pm.max_spare_servers\ =.*/pm.max_spare_servers\ =\ 100/ /usr/local/etc/php-fpm.d/www.conf

# Copy sources
COPY --chown=www-data:www-data . /app

VOLUME /data

WORKDIR  /app

RUN chmod -R a+w /app

RUN ls -la /app


COPY docker-php-entrypoint.sh /usr/local/bin/docker-php-entrypoint
RUN chmod +x /usr/local/bin/docker-php-entrypoint

ENTRYPOINT ["/usr/local/bin/docker-php-entrypoint"]
# Start php-fpm
CMD ["php-fpm"]
