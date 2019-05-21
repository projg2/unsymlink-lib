ARG STAGE
FROM ${STAGE}

COPY unsymlink-lib /usr/local/bin
# silence the warning
RUN mkdir /usr/portage
ARG EPYTHON
RUN ${EPYTHON} --version
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --analyze
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --migrate
RUN ${EPYTHON} /usr/local/bin/unsymlink-lib --finish
