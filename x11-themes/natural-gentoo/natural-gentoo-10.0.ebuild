# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

DESCRIPTION="Fbcondecor theme created and designed for the Gentoo Linux."
HOMEPAGE="http://jtyr.github.io/natural-gentoo"
SRC_URI="https://github.com/jtyr/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT=0
LICENSE="Artistic GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="grub"
#RESTRICT="binchecks strip"

#File collisions with media-gfx/splash-themes-gentoo
DEPEND="
	grub? ( || ( sys-boot/grub:0 sys-boot/grub-static ) )
	>=media-gfx/splashutils-1.4.1
	!media-gfx/splash-themes-gentoo"

S=${WORKDIR}/${P}

pkg_setup() {
	if use grub && [[ -d ${ROOT}/boot/grub ]] ; then \
		die "${ROOT}/boot/grub does not exist, please make sure you have /boot mounted"
	fi
}

src_prepare() {
	cd "${S}"/etc/splash/
	sed -i -e 's/natural-gentoo/natural_gentoo/g' natural-gentoo/*.cfg || die 'sed failed'
	mv natural-gentoo natural_gentoo
}

src_install() {
	insinto /etc/splash
	doins -r "${S}"/etc/splash/*

	if use grub ; then
	# grub splash images
		dodir /usr/share/grub/splashimages
		insinto /usr/share/grub/splashimages
		newins "${S}"/boot/grub/*.xpm.gz ${PN}.xpm.gz
	fi
}
