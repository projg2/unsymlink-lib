# Regression test for https://github.com/mgorny/unsymlink-lib/issues/8
# lib is absolute symlink rather than relative

ARG STAGE
FROM ${STAGE}

# silence the warning
RUN mkdir /usr/portage
ARG EPYTHON
RUN ${EPYTHON} --version
RUN rm /lib /usr/lib && ln -s /lib64 /lib && ln -s /usr/lib64 /usr/lib
COPY unsymlink-lib /usr/local/bin
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --analyze \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --migrate \
	&& ${EPYTHON} /usr/local/bin/unsymlink-lib --finish
