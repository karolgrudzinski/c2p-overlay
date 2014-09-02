# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="Open Source file and archive manager: flexible, portable, secure, and free as in freedom"
HOMEPAGE="http://www.peazip.org"
SRC_URI="gtk? ( http://peazip.googlecode.com/files/$P.LINUX.GTK2.tgz )
qt4? ( http://peazip.googlecode.com/files/$P.LINUX.Qt.tgz )"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-gtk +qt4 +kde -gnome"
RESTRICT=mirror

RDEPEND="amd64? ( gtk? ( app-emulation/emul-linux-x86-gtklibs ) 
	app-emulation/emul-linux-x86-baselibs 
	app-emulation/emul-linux-x86-xlibs 
	app-emulation/emul-linux-x86-opengl 
	qt4? ( app-emulation/emul-linux-x86-qtlibs ) )
x86? ( dev-libs/atk
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	media-libs/mesa
	gtk? ( x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+ )
	qt4? ( dev-qt/qtcore
	dev-qt/qtgui ) )"
DEPEND=$RDEPEND

src_unpack()
{
	if use gtk
	then
		unpack $P.LINUX.GTK2.tgz
	else
		unpack $P.LINUX.Qt.tgz
	fi
	if use !kde
	then
		rm -Rf $WORKDIR/usr/local/share/PeaZip/FreeDesktop_integration/kde4-dolphin
		rm -Rf $WORKDIR/usr/local/share/PeaZip/FreeDesktop_integration/kde3-konqueror
		rm -Rf $WORKDIR/usr/share
		rm -Rf $WORKDIR/opt/*
	fi
	if use !gnome
	then
		rm -Rf $WORKDIR/usr/local/share/PeaZip/FreeDesktop_integration/nautilus-scripts
	fi

	mkdir -p usr/share/icons/hicolor/256x256/apps
	mv usr/local/share/icons/peazip.png usr/share/icons/hicolor/256x256/apps
	rm -Rf usr/local/share/icons

	mkdir -p usr/share/applications
	mv usr/local/share/applications/PeaZip.desktop usr/share/applications/
	rm -Rf usr/local/share/applications

	cp -Rf $WORKDIR/usr/local/share/* $WORKDIR/opt
	rm -Rf $WORKDIR/usr/local

	mkdir -p usr/bin
	cd $WORKDIR/usr/bin
	ln -sf ../../opt/PeaZip/res/pea pea
	ln -sf ../../opt/PeaZip/res/pealauncher pealauncher
	ln -sf ../../opt/PeaZip/peazip peazip
	cd $WORKDIR/usr/lib
	ln -sf ../../opt/PeaZip/libqt4intf.so libqt4intf.so
	cd $WORKDIR/usr/lib32
	ln -sf ../../opt/PeaZip/libqt4intf.so libqt4intf.so
}
src_install()
{
	chmod -R 755 $WORKDIR/*
	chown root:root $WORKDIR/*
	mv $WORKDIR/* $D
}
