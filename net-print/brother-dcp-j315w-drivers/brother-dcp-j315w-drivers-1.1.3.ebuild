EAPI=4

inherit rpm multilib

DESCRIPTION="Brother DCP-J315W LPR+cupswrapper drivers"
HOMEPAGE="http://support.brother.com/g/b/downloadlist.aspx?c=pl&lang=pl&prod=dcpj315w_eu_as&os=127&flang=English"
SRC_URI="http://download.brother.com/welcome/dlf005590/dcpj315wlpr-1.1.3-1.i386.rpm
         http://download.brother.com/welcome/dlf005592/dcpj315wcupswrapper-1.1.3-1.i386.rpm"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip"

DEPEND="net-print/cups
		app-text/a2ps"
RDEPEND="${DEPEND}"

S="${WORKDIR}" # Portage will bitch about missing $S so lets pretend that we have vaild $S.

src_unpack() {
	rpm_unpack ${A}
}

src_install() {
	has_multilib_profile && ABI=x86

	dosbin "${WORKDIR}/usr/bin/brprintconf_dcpj315w"

	cp -r usr "${D}" || die
	cp -r opt "${D}" || die

	mkdir -p ${D}/usr/libexec/cups/filter || die
	( cd ${D}/usr/libexec/cups/filter/ && ln -s ../../../../opt/brother/Printers/dcpj315w/lpd/filterdcpj315w brlpdwrapperdcpj315w ) || die
	mkdir -p ${D}/usr/share/cups/model || die
	( cd ${D}/usr/share/cups/model && ln -s ../../../../opt/brother/Printers/dcpj315w/cupswrapper/brother_dcpj315w_printer_en.ppd ) || die
}

pkg_postinst () {
	ewarn "You really wanna read this."
	elog "You need to use brprintconf_dcpj315w to change printer options"
	elog "For example, you should set paper type to A4 right after instalation"
	elog "or your prints will be misaligned!"
	elog
	elog "Set A4 Paper type:"
	elog "		brprintconf_dcpj315w -pt A4"
	elog "Set 'Fast Normal' quality:"
	elog "		brprintconf_dcpj315w -reso 300x300dpi"
	elog
	elog "For more options just execute brprintconf_dcpj315w as root"
	elog "You can check current settings in:"
	elog "		/usr/local/Brother/Printer/dcpj315w/inf/brdcpj315wrc"
	elog
	elog "To add printer over WIFI add use LPD or SOCKET protocol, for example:"
	elog "		lpd://<host_or_ip>/BINARY_P1"
	elog "				- or -"
	elog "		socket://<host_or_ip>:9100"
}

# TODO: Write alternative to filterdcpj315w or patch it for the security manner.
