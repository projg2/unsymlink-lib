EAPI=7

DESCRIPTION="UTF-8 filenames to test unsymlink-lib"
HOMEPAGE=""
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"

S=${WORKDIR}

src_install() {
	dodir /usr/lib{,32,64}
	touch "${ED}"/usr/lib/ąćę.lib
	touch "${ED}"/usr/lib32/ąćę.lib32
	touch "${ED}"/usr/lib64/ąćę.lib64
}
