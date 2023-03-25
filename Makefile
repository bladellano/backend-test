include laravel-app/.env

install:
	@make down
	@make build
	@make up 
	@make composer-update
	@make perm-storage
	@make data
	@make msg
down:
	docker-compose down --remove-orphans
build:
	docker-compose build --no-cache --force-rm
stop:
	docker-compose stop
up:
	docker-compose up -d
composer-update:
	docker exec coderockr-app bash -c "composer update && php artisan key:generate"	
perm-storage:
	docker exec -t coderockr-app bash -c 'chown -R www-data:www-data /var/www/html/storage'	
data:
	docker exec coderockr-app bash -c "php artisan migrate"
	docker exec coderockr-app bash -c "php artisan db:seed"
in:
	docker exec -it coderockr-app bash
predis:
	docker exec -it predis bash
purge:
	docker-compose down --rmi all
queue:
	docker exec coderockr-app bash -c "php artisan queue:work"
test:
	docker exec -t coderockr-app bash -c "php artisan test"
msg:
	@echo "########################################################################"
	@echo "### Clique aqui para ver a api funcionando ${APP_URL}/api ###"
	@echo "########################################################################"

