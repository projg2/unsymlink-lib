DESTDIR =
PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

all:
clean:
distclean:

install:
	install -d $(DESTDIR)$(BINDIR)
	install -m0755 unsymlink-lib $(DESTDIR)$(BINDIR)/

.PHONY: all clean distclean install
