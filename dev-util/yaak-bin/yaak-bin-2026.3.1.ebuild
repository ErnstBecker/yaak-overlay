# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Fast, privacy-first, offline-first desktop API client"
HOMEPAGE="https://yaak.app https://github.com/mountain-loop/yaak"

MY_PN="yaak"
SRC_URI="https://github.com/ErnstBecker/yaak-overlay/releases/download/v${PV}/${MY_PN}-bin-${PV}-x86_64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"

RDEPEND="
	dev-libs/openssl
	dev-libs/glib:2
	net-libs/webkit-gtk:4.1
	x11-libs/gtk+:3
	x11-libs/libxcb
	x11-libs/libX11
	media-libs/mesa
"

QA_PREBUILT="
	usr/lib/${MY_PN}/yaak-app
	usr/lib/${MY_PN}/vendored/node/yaaknode
	usr/lib/${MY_PN}/vendored/protoc/yaakprotoc
"

S="${WORKDIR}/${MY_PN}-bin-${PV}-x86_64"

src_install() {
	insinto "/usr/lib/${MY_PN}"
	insopts -m0755
	doins yaak-app

	insinto "/usr/lib/${MY_PN}/vendored"
	insopts -m0644
	doins -r vendored/.

	fperms 0755 "/usr/lib/${MY_PN}/vendored/node/yaaknode"
	fperms 0755 "/usr/lib/${MY_PN}/vendored/protoc/yaakprotoc"

	dosym "/usr/lib/${MY_PN}/yaak-app" "/usr/bin/yaak"

	newicon icons/128x128.png yaak.png

	make_desktop_entry yaak "Yaak" yaak "Development;Network;"
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
