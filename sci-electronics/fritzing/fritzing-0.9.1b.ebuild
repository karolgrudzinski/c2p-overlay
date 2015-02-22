# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/fritzing/fritzing-0.7.12b.ebuild,v 1.2 2013/04/15 18:04:27 idl0r Exp $

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="Electronic Design Automation"
HOMEPAGE="http://fritzing.org/"
SRC_URI="http://fritzing.org/download/${PV}/source-tarball/${P}.source.zip"

LICENSE="CC-BY-SA-3.0 GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtserialport
	dev-qt/qtwidgets
	dev-qt/qtprintsupport
	dev-qt/qtconcurrent
	dev-qt/qtxml
	dev-libs/quazip"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.43"

S="${WORKDIR}/fritzing-app-master"

src_configure() {
	eqmake5 PREFIX=${ED}/usr DEFINES=QUAZIP_INSTALLED phoenix.pro
}
