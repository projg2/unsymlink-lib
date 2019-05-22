DESTDIR =
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# test defaults
TEST = 00basic
STAGE = gentoo/stage3-amd64
EPYTHON = python3.6
LANG = C.UTF-8

all:
clean:
distclean:

check-docker:
	docker build -f docker/$(TEST)/Dockerfile \
		--build-arg STAGE=$(STAGE) \
		--build-arg EPYTHON=$(EPYTHON) \
		--build-arg LANG=$(LANG) .

check:
	# check multilib & no-multilib profiles
	+$(MAKE) check-docker
	+$(MAKE) STAGE=gentoo/stage3-amd64-nomultilib check-docker
	# check python2.7
	+$(MAKE) EPYTHON=python2.7 check-docker
	# check whether utf-8 filenames don't kill it
	+$(MAKE) TEST=01utf8 check-docker
	+$(MAKE) EPYTHON=python2.7 TEST=01utf8 check-docker
	+$(MAKE) LANG=C TEST=01utf8 check-docker
	+$(MAKE) LANG=C EPYTHON=python2.7 TEST=01utf8 check-docker
	# check whether invalid utf-8 filenames don't kill it
	+$(MAKE) TEST=02nonutf8 check-docker
	+$(MAKE) EPYTHON=python2.7 TEST=02nonutf8 check-docker
	+$(MAKE) LANG=C TEST=02nonutf8 check-docker
	+$(MAKE) LANG=C EPYTHON=python2.7 TEST=02nonutf8 check-docker

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m0755 unsymlink-lib $(DESTDIR)$(BINDIR)/

.PHONY: all check clean distclean install
