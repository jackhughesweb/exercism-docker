all: website website/server_identity run

website:
	git clone --origin upstream --branch master https://github.com/exercism/website.git

website/server_identity: website
	echo "exercism.local" > website/server_identity

setup_db:
	docker-compose -p exercism exec rails bin/rails exercism:setup

migrate:
	docker-compose -p exercism exec rails bin/rails db:migrate

update_repos:
	docker-compose -p exercism exec rails bin/rails git:update_repos

update: migrate update_repos
init: setup_db update

run:
	docker-compose -p exercism up

console:
	docker-compose -p exercism exec rails sh

test:
	docker-compose -p exercism exec rails bin/rails test

stop:
	docker-compose -p exercism stop

clean:
	docker-compose -p exercism down && docker rmi exercism_rails

.PHONY: all setup_db migrate update_repos update init run console test stop clean
