DESTDIR =
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# test defaults
STAGE = gentoo/stage3-amd64
EPYTHON = python3.6

all:
clean:
distclean:

check-docker:
	docker build -f docker/00basic/Dockerfile \
		--build-arg STAGE=$(STAGE) \
		--build-arg EPYTHON=$(EPYTHON) .

check:
	# check multilib & no-multilib profiles
	+$(MAKE) check-docker
	+$(MAKE) STAGE=gentoo/stage3-amd64-nomultilib check-docker
	# check python2.7
	+$(MAKE) EPYTHON=python2.7 check-docker

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m0755 unsymlink-lib $(DESTDIR)$(BINDIR)/

.PHONY: all check clean distclean install
