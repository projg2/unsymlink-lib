ARG STAGE
FROM gentoo/portage AS portdir
FROM ${STAGE}

COPY docker/02nonutf8/nonutf8-files-1.ebuild /usr/portage/app-misc/nonutf8-files/
COPY --from=portdir /usr/portage/profiles /usr/portage/profiles
RUN mkdir /usr/portage/metadata \
	&& echo "thin-manifests = true" > /usr/portage/metadata/layout.conf
RUN emerge -1v nonutf8-files
RUN touch $'/usr/lib/test\x80'.{txt,so} $'/usr/lib32/test\x80'.so
ARG EPYTHON
RUN ${EPYTHON} --version
ARG LANG
RUN LANG=${LANG} locale
COPY unsymlink-lib /usr/local/bin
RUN LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --analyze
RUN LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --migrate
RUN LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --finish
