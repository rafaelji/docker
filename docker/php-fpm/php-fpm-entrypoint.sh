#!/usr/bin/env sh

if [ "$DOCKER_ENV" = "dev-local" ]; then
    sed -i 's/^;//' /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

exec docker-php-entrypoint "$@"
