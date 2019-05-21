DESTDIR =
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

all:
clean:
distclean:

check:
	docker build -f docker/00basic/Dockerfile .
	docker build -f docker/00basic/Dockerfile \
		--build-arg STAGE=gentoo/stage3-amd64-nomultilib .

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m0755 unsymlink-lib $(DESTDIR)$(BINDIR)/

.PHONY: all check clean distclean install
