.PHONY: help install buidl bash clean

VERSION := 81

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	build


build:
	docker-compose build --build-arg VERSION=$(VERSION)

bash: build
	docker-compose run --rm php bash

clean:
	docker-compose down -v
