# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

KDE_LOOK="49074"

inherit eutils

DESCRIPTION="A fbcondecor theme created and designed for the Gentoo Linux."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KDE_LOOK}"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/${KDE_LOOK}-${P}.tar.gz"

SLOT=0
LICENSE="Artistic GPL-2 as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="grub"
RESTRICT="binchecks strip"

DEPEND=">=media-gfx/splashutils-1.4.1"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
}

src_install() {
	cp -r "${S}"/etc "${D}"/
	use grub && cp -r "${S}"/boot "${D}"/
}
