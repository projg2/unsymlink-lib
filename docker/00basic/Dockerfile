ARG STAGE=gentoo/stage3-amd64
FROM ${STAGE}

COPY unsymlink-lib /usr/local/bin
# silence the warning
RUN mkdir /usr/portage
RUN unsymlink-lib --analyze
RUN unsymlink-lib --migrate
RUN unsymlink-lib --finish
