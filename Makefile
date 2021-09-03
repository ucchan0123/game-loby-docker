#-----------------------------------------------------------
# Docker
#-----------------------------------------------------------

init: build api-composer-install api-env api-key api-migrate admin-composer-install admin-env admin-key admin-migrate webpay-composer-install webpay-env webpay-key webpay-migrate client-env

re-init: build api-composer-install api-key api-migrate admin-composer-install admin-key admin-migrate webpay-composer-install webpay-key webpay-migrate

# Wake up docker containers
up:
	docker-compose up -d

# Shut down docker containers
down:
	docker-compose down

# Show a status of each container
status:
	docker-compose ps

# Status alias
s: status

# Show logs of each container
logs:
	docker-compose logs

# Restart all containers
restart: down up

# Restart the client container
restart-client:
	docker-compose restart client

# Restart the client container alias
rc: restart-client

# Show the client logs
logs-client:
	docker-compose logs client

# Show the client logs alias
lc: logs-client

# Build and up docker containers
build:
	docker-compose up -d --build

# Build containers with no cache option
build-no-cache:
	docker-compose build --no-cache

# Build and up docker containers
rebuild: down build

# Run terminal of the php container
api-php:
	docker-compose exec api-php bash

# Run terminal of the php container
admin-php:
	docker-compose exec admin-php bash

# Run terminal of the php container
webpay-php:
	docker-compose exec webpay-php bash

# Run terminal of the client container
client:
	docker-compose exec client /bin/sh


#-----------------------------------------------------------
# Logs
#-----------------------------------------------------------

# Clear file-based logs
logs-clear:
	sudo rm docker/dev/nginx/logs/*.log
	sudo rm src/api/storage/logs/*.log
	sudo rm src/admin/storage/logs/*.log


#-----------------------------------------------------------
# Installation
#-----------------------------------------------------------

client-env:
	cp .env.client ./src/client/.env

# Install composer dependencies
api-composer-install:
	docker-compose exec api-php composer install

# Run database migrations
api-migrate:
	docker-compose exec api-php php artisan migrate

# Copy the Laravel api environment file
api-env:
	cp .env.api ./src/api/.env

# Add permissions for Laravel cache and storage folders
api-permissions:
	sudo chmod -R 777 src/api/bootstrap/cache
	sudo chmod -R 777 src/api/storage

# Generate a Laravel app key
api-key:
	docker-compose exec api-php php artisan key:generate

# Install composer dependencies
admin-composer-install:
	docker-compose exec admin-php composer install

# Run database migrations
admin-migrate:
	docker-compose exec admin-php php artisan migrate

# Copy the Laravel admin environment file
admin-env:
	cp .env.admin ./src/admin/.env

# Generate a Laravel app key
admin-key:
	docker-compose exec admin-php php artisan key:generate

# Install composer dependencies
webpay-composer-install:
	docker-compose exec webpay-php composer install

# Run database migrations
webpay-migrate:
	docker-compose exec webpay-php php artisan migrate

# Copy the Laravel webpay environment file
webpay-env:
	cp .env.webpay ./src/webpay/.env

# Generate a Laravel app key
webpay-key:
	docker-compose exec webpay-php php artisan key:generate


#-----------------------------------------------------------
# Clearing
#-----------------------------------------------------------

# Shut down and remove all volumes
remove-volumes:
	docker-compose down --volumes

# Remove all existing networks (useful if network already exists with the same attributes)
prune-networks:
	docker network prune

# Clear cache
prune-a:
	docker system prune -a
