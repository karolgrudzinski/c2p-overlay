# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="Fbcondecor theme created and designed for the Gentoo Linux."
HOMEPAGE="http://jtyr.github.io/natural-gentoo"
SRC_URI="https://github.com/jtyr/${PN}/archive/${PV}.zip"

SLOT=0
LICENSE="Artistic GPL-2 as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="grub"
RESTRICT="binchecks strip"

DEPEND=">=media-gfx/splashutils-1.4.1"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
}

src_install() {
	cp -r "${S}"/etc "${D}"/
	use grub && cp -r "${S}"/boot "${D}"/
}
