ARG STAGE
FROM gentoo/portage AS portdir
FROM ${STAGE}

RUN mkdir -p /usr/portage/metadata \
	&& echo "thin-manifests = true" > /usr/portage/metadata/layout.conf
COPY --from=portdir /usr/portage/profiles /usr/portage/profiles
COPY docker/02nonutf8/nonutf8-files-1.ebuild /usr/portage/app-misc/nonutf8-files/
RUN emerge -1v nonutf8-files \
	&& touch $'/usr/lib/test\x80'.{txt,so} $'/usr/lib32/test\x80'.so
ARG EPYTHON
ARG LANG
RUN ${EPYTHON} --version \
	&& LANG=${LANG} locale
COPY unsymlink-lib /usr/local/bin
RUN LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --analyze \
	&& LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --migrate \
	&& LANG=${LANG} ${EPYTHON} /usr/local/bin/unsymlink-lib --finish
