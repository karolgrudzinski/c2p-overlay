# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="Carlito font for Chrom*OS by Huerta Tipografia"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh x86 ~x86-fbsd"
IUSE=""

RESTRICT="binchecks strip test"

FONT_SUFFIX="ttf"
FONT_CONF=( "${FILESDIR}"/62-carlito.conf )
