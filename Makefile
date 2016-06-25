# Read the version we are packaging from VERSION.txt
VERSION := $(shell cat VERSION.txt)

all: rpm

deps:
	gem install fpm

deps-macos:
	brew install rpm

deps-circle:
	sudo apt-get install rpm
	gem install package_cloud

rpm:
	bash scripts/build-rpm.sh

.PHONY: all
