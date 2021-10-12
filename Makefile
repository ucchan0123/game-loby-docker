#-----------------------------------------------------------
# Docker
#-----------------------------------------------------------

init: build api-composer-install api-key api-migrate

up:
	docker-compose up -d

down:
	docker-compose down

status:
	docker-compose ps

logs:
	docker-compose logs

build:
	docker-compose up -d --build

build-no-cache:
	docker-compose build --no-cache

api-php:
	docker-compose exec api-php bash

client:
	docker-compose exec client /bin/sh


#-----------------------------------------------------------
# Installation
#-----------------------------------------------------------

api-composer-install:
	docker-compose exec api-php composer install

api-migrate:
	docker-compose exec api-php php artisan migrate

api-permissions:
	sudo chmod -R 777 src/api/bootstrap/cache
	sudo chmod -R 777 src/api/storage

api-key:
	docker-compose exec api-php php artisan key:generate

#-----------------------------------------------------------
# Clearing
#-----------------------------------------------------------

remove-volumes:
	docker-compose down --volumes

prune-networks:
	docker network prune

prune-a:
	docker system prune -a
