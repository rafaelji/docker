#!/usr/bin/env sh

envsubst '\$NGINX_HOST \$PHP_FPM_HOST' < /etc/nginx/conf.d/projeto.template > /etc/nginx/conf.d/projeto.conf

exec "$@"
