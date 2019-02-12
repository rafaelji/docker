FROM php:7.2-fpm-alpine

ENV XDEBUG_VERSION 2.6.0

RUN apk add --no-cache --virtual .persistent-deps \
        fcgi \
        git \
        icu-libs \
        zlib \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        icu-dev \
        zlib-dev \
    && docker-php-ext-install \
        intl \
        pdo \
        pdo_mysql \
        zip \
    && pecl install \
        apcu \
        xdebug-${XDEBUG_VERSION} \
    && docker-php-ext-enable \
        apcu \
        opcache \
        xdebug \
    && apk del .build-deps

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /root/.composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /application

COPY docker/php-fpm/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY docker/php-fpm/php.ini /usr/local/etc/php/php.ini
COPY docker/php-fpm/overrides.conf /usr/local/etc/php-fpm.d/zz-overrides.conf
COPY docker/php-fpm/php-fpm-entrypoint.sh /usr/local/bin

# Disable Xdebug by default
RUN sed -i 's/^/;/' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

ENTRYPOINT ["php-fpm-entrypoint.sh"]

CMD ["php-fpm"]
