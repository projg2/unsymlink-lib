# Regression test for https://bugs.gentoo.org/688216
# Migrating a system where .keepfiles were removed

ARG STAGE
FROM ${STAGE}

# silence the warning
RUN mkdir /usr/portage
ARG EPYTHON
RUN ${EPYTHON} --version
RUN find /lib* /usr/lib* -name '.keep*' -delete
COPY unsymlink-lib /usr/local/bin
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --analyze \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --migrate \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --finish
