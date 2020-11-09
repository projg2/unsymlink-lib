DESTDIR =
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

# test defaults
TEST = 00basic
STAGE = gentoo/stage3-amd64
# A tag known to have an unmigrated stage3, with passing tests.
STAGE_TAG = 20190619
PORTAGE_TAG = 20190618
EPYTHON = python3.6
LANG = C.UTF-8

# set this to command used to prune docker images if necessary
DOCKER_CLEANUP =

all:
clean:
distclean:

check-docker:
	docker build -f docker/$(TEST)/Dockerfile \
		--build-arg STAGE=$(STAGE):$(STAGE_TAG) \
		--build-arg PORTAGE_TAG=$(PORTAGE_TAG) \
		--build-arg EPYTHON=$(EPYTHON) \
		--build-arg LANG=$(LANG) .

check:
	# check multilib & no-multilib profiles
	+$(MAKE) check-docker
	+$(MAKE) STAGE=gentoo/stage3-amd64-nomultilib check-docker
	# regression tests
	+$(MAKE) TEST=00abslibsymlink check-docker
	+$(MAKE) TEST=00rmkeepfiles check-docker
	# check python2.7
	+$(MAKE) EPYTHON=python2.7 check-docker
	# Check for hardlink instead of copy
	+$(MAKE) TEST=02hardlink check-docker
	+$(MAKE) STAGE=gentoo/stage3-amd64-nomultilib TEST=02hardlink check-docker
	$(DOCKER_CLEANUP)
	# check whether utf-8 filenames don't kill it
	+$(MAKE) TEST=01utf8 check-docker
	+$(MAKE) EPYTHON=python2.7 TEST=01utf8 check-docker
	+$(MAKE) LANG=C TEST=01utf8 check-docker
	+$(MAKE) LANG=C EPYTHON=python2.7 TEST=01utf8 check-docker
	$(DOCKER_CLEANUP)
	# check whether invalid utf-8 filenames don't kill it
	+$(MAKE) TEST=02nonutf8 check-docker
	+$(MAKE) EPYTHON=python2.7 TEST=02nonutf8 check-docker
	+$(MAKE) LANG=C TEST=02nonutf8 check-docker
	+$(MAKE) LANG=C EPYTHON=python2.7 TEST=02nonutf8 check-docker
	$(DOCKER_CLEANUP)
	# check for Prefix scenarios
	+$(MAKE) TEST=03prefix check-docker
	+$(MAKE) TEST=03prefix-unprivileged check-docker
	$(DOCKER_CLEANUP)

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m0755 unsymlink-lib $(DESTDIR)$(BINDIR)/

.PHONY: all check clean distclean install
