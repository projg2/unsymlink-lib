ARG STAGE
FROM ${STAGE}

# silence the warning
RUN mkdir /usr/portage
ARG EPYTHON
RUN ${EPYTHON} --version
COPY unsymlink-lib /usr/local/bin
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --analyze \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --migrate --hardlink \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --finish
