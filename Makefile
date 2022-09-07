.PHONY: help install check check-all clean

VERSION := 6.2

help:
	@cat $(firstword $(MAKEFILE_LIST))

install: \
	dependency/symfony/symfony \
	dependency/tamakiii-sandbox/init-symfony-$(VERSION)

check: |dependency/symfony/symfony dependency/tamakiii-sandbox/init-symfony-$(VERSION)
	git -C $(word 1,$|) checkout $(VERSION)
	@echo "---"
	@echo "symfony/symfony"
	@echo "version\t$(VERSION)"
	@echo "require.php\t$(shell cat $(word 1,$|)/composer.json | jq -r '.require.php')"
	@echo "---"
	@echo "tamakiii-sandbox/init-symfony-$(VERSION)"
	@echo "require.php\t$(shell cat $(word 2,$|)/composer.json | jq -r '.require.php')"
	@echo "platform.php\t$(shell cat $(word 2,$|)/composer.lock | jq -r '.platform.php')"
	@echo "platform-overrides.php\t$(shell cat $(word 2,$|)/composer.lock | jq -r '.["platform-overrides"].php')"
	@echo "---"

check-all:
	$(MAKE) check VERSION=2.7
	$(MAKE) check VERSION=2.8
	$(MAKE) check VERSION=3.0
	$(MAKE) check VERSION=3.1
	$(MAKE) check VERSION=3.2
	$(MAKE) check VERSION=3.3
	$(MAKE) check VERSION=3.4
	$(MAKE) check VERSION=4.4
	$(MAKE) check VERSION=5.1
	$(MAKE) check VERSION=5.2
	$(MAKE) check VERSION=5.3
	$(MAKE) check VERSION=5.4
	$(MAKE) check VERSION=6.0
	$(MAKE) check VERSION=6.1

dependency/symfony/symfony: |dependency/symfony
	git clone https://github.com/symfony/symfony.git $@

dependency/symfony: |dependency
	mkdir $@

dependency/tamakiii-sandbox/init-symfony-$(VERSION): |dependency/tamakiii-sandbox
	git clone git@github.com:tamakiii-sandbox/init-symfony-$(VERSION).git $@

dependency/tamakiii-sandbox: |dependency
	mkdir $@

dependency:
	mkdir $@

clean:
	rm -rf dependency
