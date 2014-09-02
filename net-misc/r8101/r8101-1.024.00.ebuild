# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit linux-info toolchain-funcs linux-mod eutils

DESCRIPTION="Drivers for Realtek 810x 840x based PCI-E/PCI Ethernet Cards"
HOMEPAGE="http://www.realtek.com.tw/ http://bit.ly/1c8XQqN"
#MY_PV="v${PV}"
#MY_P="${PN}-${MY_PV}"
RESTRICT="fetch"
#RESTRICT="mirror"
#SRC_URI="
#    http://www.realtek.com.tw/downloads/RedirectFTPSite.aspx?SiteID=1&DownTypeID=3&DownID=263&PFid=7&Conn=4&FTPPath=ftp%3a%2f%2f58.211.24.153%2fcn%2fnic/r8101-1.024.00.tar.bz2
#    http://www.realtek.com.tw/downloads/RedirectFTPSite.aspx?SiteID=2&DownTypeID=3&DownID=263&PFid=7&Conn=4&FTPPath=ftp%3a%2f%2f95.130.192.218%2fcn%2fnic/r8101-1.024.00.tar.bz2
#    http://www.realtek.com.tw/downloads/RedirectFTPSite.aspx?SiteID=3&DownTypeID=3&DownID=263&PFid=7&Conn=4&FTPPath=ftp%3a%2f%2f208.70.202.219%2fcn%2fnic/r8101-1.024.00.tar.bz2
#    http://www.realtek.com.tw/downloads/RedirectFTPSite.aspx?SiteID=4&DownTypeID=3&DownID=263&PFid=7&Conn=4&FTPPath=ftp%3a%2f%2f207.232.93.28%2fcn%2fnic/r8101-1.024.00.tar.bz2
#    http://www.realtek.com.tw/downloads/RedirectFTPSite.aspx?SiteID=5&DownTypeID=3&DownID=263&PFid=7&Conn=4&FTPPath=ftp%3a%2f%2f209.222.7.36%2fcn%2fnic/r8101-1.024.00.tar.bz2
#    http://www.realtek.com.tw/downloads/RedirectFTPSite.aspx?SiteID=6&DownTypeID=3&DownID=263&PFid=7&Conn=4&FTPPath=ftp%3a%2f%2f202.134.71.21%2fcn%2fnic/r8101-1.024.00.tar.bz2
#    "
SRC_URI="ftp://61.56.86.122/cn/nic/${P}.tar.bz2
    ftp://210.51.181.211/cn/nic/${P}.tar.bz2
    ftp://152.104.238.194/cn/nic/${P}.tar.bz2"
LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"

IUSE=""
#DEPEND="sys-kernel/linux-headers"
#RDEPEND=""

#S=${WORKDIR}/${MY_P}

MODULE_NAMES="r8101(net/ethernet::src)"
BUILD_TARGETS="modules"

src_prepare() {
    if kernel_is ge 3 10; then
        epatch ${FILESDIR}/r8101-linux-3.10.patch
    fi

    if kernel_is ge 3 15; then
        epatch ${FILESDIR}/r8101-linux-3.15.patch
        epatch ${FILESDIR}/r8101-linux-3.15plus.patch
    fi
}

pkg_setup() {
    linux-mod_pkg_setup
    BUILD_PARAMS="KERNELDIR=${KV_DIR}"
}
