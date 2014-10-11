# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit linux-info toolchain-funcs linux-mod eutils

DESCRIPTION="Drivers for Realtek 810x 840x based PCI-E/PCI Ethernet Cards"
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
    einfo "from ${HOMEPAGE} and place file ${P}.tar.bz2 in ${DISTDIR}"
}

pkg_setup() {
    linux-mod_pkg_setup
    BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}
