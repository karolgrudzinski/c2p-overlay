# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils fdo-mime

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
SRC_URI="x86? ( http://download.xnview.com/old_versions/XnViewMP-081-linux.tgz )
	   amd64? ( http://download.xnview.com/old_versions/XnViewMP-081-linux-x64.tgz )"

SLOT="0"
LICENSE="freedist XnView"
KEYWORDS="~x86 ~amd64"
IUSE="bundled-libs"

BUNDLED_LIBS="
	libQt5Core.so.5	   libQt5Core.so.5.5.1
	libQt5Gui.so.5	  libQt5Gui.so.5.5.1
	libQt5XcbQpa.so.5	 libQt5XcbQpa.so.5.5.1
	libQt5Multimedia.so.5	 libQt5Multimedia.so.5.5.1
	libQt5MultimediaWidgets.so.5	libQt5MultimediaWidgets.so.5.5.1
	libQt5DBus.so.5	   libQt5DBus.so.5.5.1
	libQt5Network.so.5	  libQt5Network.so.5.5.1
	libQt5PrintSupport.so.5	   libQt5PrintSupport.so.5.5.1
	libQt5Svg.so.5	  libQt5Svg.so.5.5.1
	libQt5OpenGL.so.5	 libQt5OpenGL.so.5.5.1
	libQt5Positioning.so.5	  libQt5Positioning.so.5.5.1
	libQt5Qml.so.5	  libQt5Qml.so.5.5.1
	libQt5Quick.so.5	libQt5Quick.so.5.5.1
	libQt5Sensors.so.5	  libQt5Sensors.so.5.5.1
	libQt5Sql.so.5	  libQt5Sql.so.5.5.1
	libQt5WebChannel.so.5	 libQt5WebChannel.so.5.5.1
	libQt5WebKit.so.5	 libQt5WebKit.so.5.5.1
	libQt5WebKitWidgets.so.5	libQt5WebKitWidgets.so.5.5.1
	libQt5Widgets.so.5	  libQt5Widgets.so.5.5.1
	libQt5X11Extras.so.5	libQt5X11Extras.so.5.5.1
	libQt5Xml.so.5	  libQt5Xml.so.5.5.1
	libQt5Concurrent.so.5	 libQt5Concurrent.so.5.5.1
	libicudata.so.54	libicui18n.so.54	libicuuc.so.54
	libicudata.so.54.1	libicui18n.so.54.1	libicuuc.so.54.1
	audio/ platforms/ printsupport/"

BUNDLED_LIBS_DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtx11extras:5
	dev-qt/qtconcurrent:5
	dev-qt/qtxml:5
	dev-qt/qtopengl:5
	dev-qt/qtsql:5
	dev-qt/qtdbus:5
	dev-qt/qtwebkit:5
	dev-qt/qtimageformats:5
	dev-libs/icu"

RDEPEND=">=dev-libs/glib-2
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	!bundled-libs? ( ${BUNDLED_LIBS_DEPEND} )
	"
DEPEND=""

RESTRICT="strip mirror"
S="${WORKDIR}/XnView"

src_prepare() {
	default

	if ! use bundled-libs ; then
		einfo Removing bundled libraries
		for libname in ${BUNDLED_LIBS} ; do
			rm -rv "${S}"/lib/${libname} || die "Failed removing bundled ${libname}"
		done
		rm "${S}"/qt.conf
	fi
}

src_install() {
	declare XNVIEW_HOME=/opt/XnView

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

pkg_postinst(){
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
