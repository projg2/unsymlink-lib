ARG STAGE
FROM ${STAGE}

# silence the warning
RUN useradd -m frob \
	&& mkdir /usr/portage /home/frob/gentoo \
	&& cp --reflink=auto -xa /{bin,etc,lib*,sbin,usr,var} /home/frob/gentoo/ \
	&& chown -R frob /home/frob/gentoo
ARG EPYTHON
RUN ${EPYTHON} --version
COPY unsymlink-lib /usr/local/bin
USER frob
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --root /home/frob/gentoo --unprivileged --analyze \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --root /home/frob/gentoo --unprivileged --migrate \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --root /home/frob/gentoo --unprivileged --finish \
	&& test -h /usr/lib \
	&& test -d /home/frob/gentoo/lib \
	&& test -f /usr/lib/libattr.so \
	&& ! test -f /home/frob/gentoo/lib/libattr.so
