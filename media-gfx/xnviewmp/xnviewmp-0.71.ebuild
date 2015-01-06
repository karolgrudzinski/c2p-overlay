# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ( http://download.xnview.com/XnViewMP-linux.tgz )
       amd64? ( http://download.xnview.com/XnViewMP-linux-x64.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-libs/glib-2
    x11-libs/libX11
    x11-libs/libXi
    x11-libs/libXt
    dev-qt/qtgui:4"
DEPEND=""

RESTRICT="strip"
S="${WORKDIR}/XnView"

src_install() {
    declare XNVIEW_HOME=/opt/XnView

    # Remove bundled libraries
    rm ${S}/lib/libQt* ${S}/lib/libphonon*
    rm -r ${S}/lib/phonon_backend

    # Install XnView in /opt
    dodir ${XNVIEW_HOME%/*}
    mv "${S}" "${D}"${XNVIEW_HOME} || die "Unable to install XnView folder"

    # Create /opt/bin/xnview
    dodir /opt/bin/
    dosym ${XNVIEW_HOME}/XnView /opt/bin/xnview

    # Install icon and .desktop for menu entry
    newicon "${D}"${XNVIEW_HOME}/xnview.png ${PN}.png
    make_desktop_entry xnview XnviewMP ${PN} "Graphics" || die "desktop file sed failed"
}
