all: website website-copy website/server_identity run
detatched: website website-copy website/server_identity run_detatched
detatched_init: website website-copy website/server_identity run_detatched init
production: website website-copy website/server_identity run_production
production_init: website website-copy website/server_identity run_production init

website:
	git clone --origin upstream --branch master https://github.com/exercism/website.git

website-copy:
	git clone --origin upstream --branch master https://github.com/exercism/website-copy.git

website/server_identity: website
	echo "exercism.local" > website/server_identity

setup_db:
	docker-compose -p exercism exec rails bin/rails exercism:setup

migrate:
	docker-compose -p exercism exec rails bin/rails db:migrate

update_repos:
	docker-compose -p exercism exec rails bin/rails git:update_repos
	( cd website-copy && git pull upstream master )

update: migrate update_repos
init: setup_db update

run:
	docker-compose -p exercism up

run_detatched:
	docker-compose -f docker-compose.yml -f production.yml -p exercism up -d

run_production:
	docker-compose -f docker-compose.yml -f production.yml -p exercism up -d

console:
	docker-compose -p exercism exec rails sh

test:
	docker-compose -p exercism exec rails bundle exec rake db:drop RAILS_ENV=test || true
	docker-compose -p exercism exec rails bundle exec rake db:create RAILS_ENV=test
	docker-compose -p exercism exec rails bundle exec rake db:test:prepare RAILS_ENV=test
	docker-compose -p exercism exec rails bin/rails test RAILS_ENV=test
	docker-compose -p exercism exec rails bin/rails test:system RAILS_ENV=test

stop:
	docker-compose -p exercism stop

clean:
	docker-compose -p exercism down && docker rmi exercism_rails

.PHONY: all detatched detatched_init production_init setup_db migrate update_repos update init run run_detatched run_production console test stop clean
