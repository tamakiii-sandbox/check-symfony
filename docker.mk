.PHONY: help install buidl bash check clean

VERSION := 81
SYMFONY_VERSION := 6.1

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	build


build:
	docker-compose build --build-arg VERSION=$(VERSION)

bash: build | dependency/tamakiii-sandbox/init-symfony-$(SYMFONY_VERSION)
	docker-compose run --rm -v $(realpath $|):/tmp -w /tmp php bash

check: build | dependency/tamakiii-sandbox/init-symfony-$(SYMFONY_VERSION)
	docker-compose run --rm -v $(realpath $|):/tmp -w /tmp php bash -c 'composer install && bin/console --version'

clean:
	docker-compose down -v
