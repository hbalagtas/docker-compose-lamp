FROM php:7.4.2-apache-buster
#FROM php:7.4.2-apache

# Surpresses debconf complaints of trying to install apt packages interactively
# https://github.com/moby/moby/issues/4032#issuecomment-192327844
 
ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt-get -y update --fix-missing && \
    apt-get upgrade -y && \
    apt-get --no-install-recommends install -y apt-utils && \
    rm -rf /var/lib/apt/lists/*


# Install useful tools and install important libaries
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install nano wget \
dialog \
libsqlite3-dev \
libsqlite3-0 && \
    apt-get -y --no-install-recommends install default-mysql-client \
zlib1g-dev \
libzip-dev \
libicu-dev && \
    apt-get -y --no-install-recommends install --fix-missing apt-utils \
build-essential \
git \
curl \
libonig-dev && \ 
    apt-get install -y iputils-ping && \
    apt-get -y --no-install-recommends install --fix-missing libcurl4 \
libcurl4-openssl-dev \
zip \
openssl && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install xdebug
RUN pecl install xdebug-3.1.4 && \
    docker-php-ext-enable xdebug && \
    mkdir /var/log/xdebug

# Install redis
RUN pecl install redis-5.1.1 && \
    docker-php-ext-enable redis

# Install imagick
RUN apt-get update && \
    apt-get -y --no-install-recommends install --fix-missing libmagickwand-dev && \
    rm -rf /var/lib/apt/lists/* && \
    pecl install imagick && \
    docker-php-ext-enable imagick

# Other PHP7 Extensions

RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-install pdo_sqlite && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install curl && \
    docker-php-ext-install tokenizer && \
    docker-php-ext-install json && \
    docker-php-ext-install zip && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install gettext && \
    docker-php-ext-install calendar && \
    docker-php-ext-install exif

# OFAS Extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing ghostscript

RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing libldap2-dev

RUN docker-php-ext-install ldap

# OFAS extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing ghostscript

RUN apt-get update && \
    apt-get install -y --no-install-recommends --fix-missing libldap2-dev

#RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap

# Install memcached
# RUN apt-get update \
#     && apt-get install -y libmemcached11 libmemcachedutil2 build-essential libmemcached-dev libz-dev \
#     && pecl install memcached \
#     && echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini \
#     && apt-get remove -y build-essential libmemcached-dev libz-dev \
#     && apt-get autoremove -y \
#     && apt-get clean \
#     && rm -rf /tmp/pear \
#     && apt-get install -y memcached

# Install supervisord
RUN apt-get update && apt-get upgrade -y && apt-get install -y supervisor

# Make supervisor log directory
RUN mkdir -p /var/log/supervisor

# Copy local supervisord.conf to the conf.d directory
COPY --chown=root:root supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

# Install vim
RUN apt-get update && apt-get upgrade -y && apt-get install -y vim

# Install Freetype 
RUN apt-get -y update && \
    apt-get --no-install-recommends install -y libfreetype6-dev \
libjpeg62-turbo-dev \
libpng-dev && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd

# Insure an SSL directory exists
RUN mkdir -p /etc/apache2/ssl

# Enable SSL support
RUN a2enmod ssl && a2enmod rewrite

# Enable apache modules
RUN a2enmod rewrite headers

# Cleanup
RUN rm -rf /usr/src/*
