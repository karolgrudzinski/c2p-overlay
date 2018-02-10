# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit pax-utils prefix versionator rpm xdg-utils gnome2-utils

DESCRIPTION="A full office productivity suite. Binary package"
HOMEPAGE="http://www.libreoffice.org"

MY_PV2=$(get_version_component_range 1-2)
MY_PV3=$(get_version_component_range 1-3)
MY_PV4=$(get_version_component_range 1-4)

SRC_URI_BASE="http://download.documentfoundation.org/libreoffice"
SRC_URI_AMD64_STABLE="${SRC_URI_BASE}/stable/${MY_PV3}/rpm/x86_64/LibreOffice_${MY_PV3}_Linux_x86-64_rpm.tar.gz"
SRC_URI_AMD64_TESTING="${SRC_URI_BASE}/testing/${MY_PV3}/rpm/x86_64/LibreOffice_${PV}_Linux_x86-64_rpm.tar.gz"
SRC_URI_X86_STABLE="${SRC_URI_BASE}/stable/${MY_PV3}/rpm/x86/LibreOffice_${MY_PV3}_Linux_x86_rpm.tar.gz"
SRC_URI_X86_TESTING="${SRC_URI_BASE}/testing/${MY_PV3}/rpm/x86/LibreOffice_${PV}_Linux_x86_rpm.tar.gz"

SRC_URI="
	amd64? ( ${SRC_URI_AMD64_STABLE} -> LibreOffice_${PV}_Linux_x86-64_rpm.tar.gz
			${SRC_URI_AMD64_TESTING} )
	x86? ( ${SRC_URI_X86_STABLE} -> LibreOffice_${PV}_Linux_x86_rpm.tar.gz
			${SRC_URI_X86_TESTING} )
"

IUSE=""
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

PDEPEND="
	=app-office/libreoffice-l10n-${PV}*
"

RESTRICT="test strip mirror"

S="${WORKDIR}"

QA_PREBUILT="/usr/*"

src_prepare() {
	cp "${FILESDIR}"/50-${PN} "${T}"
	eprefixify "${T}"/50-${PN}
	default

	local rpmdir
	use amd64 && rpmdir="LibreOffice_${PV}_Linux_x86-64_rpm/RPMS/"
	use x86 && rpmdir="LibreOffice_${PV}_Linux_x86_rpm/RPMS/"
	[[ -d ${rpmdir} ]] || die "Missing directory: ${rpmdir}"
	rpm_unpack ./${rpmdir}/*.rpm
}

src_install() {
	local progdir=/usr/$(get_libdir)/libreoffice
	dodir ${progdir}
	mv "${S}"/opt/libreoffice"${MY_PV2}"/* "${ED}"/"${progdir}"/

	rm ./usr/bin/libreoffice"${MY_PV2}"
	dosym "${progdir}"/program/soffice /usr/bin/libreoffice"${MY_PV2}"
	dosym "${progdir}"/program/soffice /usr/bin/libreoffice
	dosym "${progdir}"/program/soffice /usr/bin/loffice
	dosym "${progdir}"/program/soffice /usr/bin/soffice
	for prog in base impress calc math writer draw; do
		dosym "${progdir}"/program/s"${prog}" /usr/bin/lo"${prog}"
	done

	rm ./usr/share/applications/*
	mkdir -p "${ED}"/usr/share/applications
	for prog in base impress startcenter calc math writer draw xsltfilter; do
		cp "${ED}"/"${progdir}"/share/xdg/"${prog}".desktop "${ED}"/usr/share/applications/libreoffice"${MY_PV2}"-"${prog}".desktop
	done

	doins -r usr

	insinto /etc/revdep-rebuild && doins "${T}/50-${PN}"
}

pkg_postinst() {
	pax-mark -m "${EPREFIX}"/usr/$(get_libdir)/libreoffice/program/soffice.bin
	pax-mark -m "${EPREFIX}"/usr/$(get_libdir)/libreoffice/program/unopkg.bin
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
