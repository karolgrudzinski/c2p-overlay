# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils linux-info toolchain-funcs linux-mod

DESCRIPTION="Driver for Realtek 810x/840x based PCI-E/PCI Ethernet Cards (PCI_ID 10ec:8136)"
HOMEPAGE="http://www.realtek.com.tw/downloads/downloadsView.aspx?Langid=1&PNid=14&PFid=7&Level=5&Conn=4&DownTypeID=3&GetDown=false#2"
RESTRICT="fetch"
SRC_URI="${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
#DEPEND="sys-kernel/linux-headers"
#RDEPEND=""

#S=${WORKDIR}/${MY_P}

MODULE_NAMES="r8101(net/ethernet::src)"
BUILD_TARGETS="modules"

pkg_nofetch() {
	einfo "Please download 'LINUX driver for kernel 3.x and 2.6.x and 2.4.x'"
	einfo "from ${HOMEPAGE}, change its name from 0007-${P}.tar.bz2 to ${P}.tar.bz2 and place file in ${DISTDIR}"
}

src_prepare() {
	if kernel_is ge 4 0; then
		eapply "${FILESDIR}"/r8101-linux-4.0-compat.patch
	fi
# 	if kernel_is ge 4 7; then
# 		epatch "${FILESDIR}"/r8101-linux-4.7-compat1.patch
# 		epatch "${FILESDIR}"/r8101-linux-4.7-compat2.patch
# 	fi
	if kernel_is ge 4 11; then
		eapply "${FILESDIR}"/r8101-linux-4.11-compat.patch
	fi

	eapply_user
}

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}

src_install() {
	linux-mod_src_install
}
