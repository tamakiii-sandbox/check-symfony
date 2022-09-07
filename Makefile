.PHONY: help install check clean

VERSION := 6.2

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependency/symfony/symfony

check: |dependency/symfony/symfony
	git -C $| checkout $(VERSION)
	@echo "---"
	@echo "VERSION\t$(VERSION)"
	@echo "REQUIRE.PHP\t$(shell cat $|/composer.json | jq -r '.require.php')"
	@echo "---"

dependency/symfony/symfony: |dependency/symfony
	git clone https://github.com/symfony/symfony.git $@

dependency/symfony: |dependency
	mkdir $@

dependency:
	mkdir $@

clean:
	rm -rf dependency
