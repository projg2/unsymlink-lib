EAPI=7

DESCRIPTION="Invalid UTF-8 filenames to test unsymlink-lib"
HOMEPAGE=""
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"

S=${WORKDIR}

src_install() {
	dodir /usr/lib{,32,64}
	touch "${ED}"$'/usr/lib/test\x80.lib'
	touch "${ED}"$'/usr/lib32/test\x80.lib32'
	touch "${ED}"$'/usr/lib64/test\x80.lib64'
}
