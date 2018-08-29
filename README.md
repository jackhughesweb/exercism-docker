# Exercism Docker Environment

Setup [exercism.io](https://exercism.io) for development using Docker and
docker-compose. Adapted from [unused/exercism-docker](https://github.com/unused/exercism-docker).

TL;DR

First run:
```
$ git clone https://github.com/jackhughesweb/exercism-docker.git # Download this repo
$ cd exercism-docker # Change directory
$ make # Builds and starts the server (OR `make production`)
$ make init # One-time initialization run while the server is up (database migration and seed) - run in a new shell while the server is up
```

Future runs:
```
$ make # starts the server (OR `make production`)
```

Other useful commands (these should be run in a new shell while the server is up):
```
$ make migrate # perform rake db:migrate
$ make update # performs rake db:migrate and sync Git repos (will run during `make init`)
$ make console # attaches to the rails server and opens a shell
$ make test # runs rake test
$ make stop # stops server
```

(Note: it is best to add exercism.local and teams.exercism.local to /etc/hosts, to access both the main and team websites):
```
127.0.0.1 exercism.local
127.0.0.1 teams.exercism.local
```
