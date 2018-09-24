#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

if [ "$1" = 'php-fpm' ] || [ "$1" = 'bin/console' ]; then
	mkdir -p var/cache var/logs public/media
	setfacl -R -m u:www-data:rwX -m u:"$(whoami)":rwX var public/media
	setfacl -dR -m u:www-data:rwX -m u:"$(whoami)":rwX var public/media

	if [ "$SYMFONY_ENV" != 'prod' ]; then
		composer install --prefer-dist --no-progress --no-suggest --no-interaction
		bin/console assets:install web --no-interaction
	fi

	>&2 echo "Waiting for MySQL to be ready..."
	#until select="$(echo 'SELECT 1' | mysql --host="${SYLIUS_DATABASE_HOST}" --database="${SYLIUS_DATABASE_NAME}" --user="${SYLIUS_DATABASE_USER}" --password="${SYLIUS_DATABASE_PASSWORD}" --silent)" && [ "$select" = '1' ]; do
	#	sleep 1
	#done
	#if [ "$(ls -A app/migrations/*.php 2> /dev/null)" ]; then
	#	bin/console doctrine:migrations:migrate --no-interaction
	#fi
fi

exec docker-php-entrypoint "$@"
