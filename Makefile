all: website website/server_identity run

website:
	git clone --origin upstream --branch master https://github.com/exercism/website.git

website/server_identity: website
	echo "exercism.local" > website/server_identity

init:
	docker-compose -p exercism exec rails bin/rails exercism:setup

migrate:
	docker-compose -p exercism exec rails bin/rails db:migrate

update_repos:
	docker-compose -p exercism exec rails bin/rails git:update_repos

update: migrate update_repos

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

.PHONY: all init migrate update_repos update run console test stop clean
