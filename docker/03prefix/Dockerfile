ARG STAGE
FROM ${STAGE}

# silence the warning
RUN mkdir /usr/portage /mnt/prefix \
	&& cp --reflink=auto -xa /{bin,etc,lib*,sbin,usr,var} /mnt/prefix/
ARG EPYTHON
RUN ${EPYTHON} --version
COPY unsymlink-lib /usr/local/bin
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --root /mnt/prefix --analyze \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --root /mnt/prefix --migrate \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --root /mnt/prefix --finish \
	&& test -h /usr/lib \
	&& test -d /mnt/prefix/lib \
	&& test -f /usr/lib/libattr.so \
	&& ! test -f /mnt/prefix/lib/libattr.so
