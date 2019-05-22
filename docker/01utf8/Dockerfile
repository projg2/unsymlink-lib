ARG STAGE
FROM gentoo/portage AS portdir
FROM ${STAGE}

RUN mkdir -p /usr/portage/metadata \
	&& echo "thin-manifests = true" > /usr/portage/metadata/layout.conf
COPY --from=portdir /usr/portage/profiles /usr/portage/profiles
COPY docker/01utf8/utf8-files-1.ebuild /usr/portage/app-misc/utf8-files/
RUN emerge -1v utf8-files
RUN touch /usr/lib/ąćęłńóśźż.{txt,so} /usr/lib32/ąćęłńóśźż.so
ARG EPYTHON
RUN ${EPYTHON} --version
ARG LANG
RUN LANG=${LANG} locale
COPY unsymlink-lib /usr/local/bin
RUN LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --analyze
RUN LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --migrate
RUN LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --finish
