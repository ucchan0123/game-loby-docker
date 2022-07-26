# Image
FROM php:8.0-fpm

# Starting from scratch
RUN apt-get clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Dependencies
RUN apt-get update

# Zip
RUN apt-get install -y libzip-dev zip && docker-php-ext-configure zip && docker-php-ext-install zip

# Git
RUN apt-get install -y git

# Curl
RUN apt-get install -y libcurl3-dev curl && docker-php-ext-install curl

# GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install gd

# OPcache
RUN docker-php-ext-configure opcache --enable-opcache
RUN docker-php-ext-install opcache

# MySQL
RUN docker-php-ext-install pdo_mysql

# BC Math
RUN docker-php-ext-install bcmath

# Human Language and Character Encoding Support
RUN apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl

# PHP Redis extension
RUN git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis && \
    docker-php-ext-install redis

# Custom php.ini config
COPY php.ini /usr/local/etc/php/php.ini

# Composer installation
COPY --from=composer:2.1 /usr/bin/composer /usr/local/bin/composer

# Set Composer Config
RUN composer config -g process-timeout 3600 && \
    composer config -g repos.packagist composer https://packagist.org

# Clean up
RUN apt-get clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
