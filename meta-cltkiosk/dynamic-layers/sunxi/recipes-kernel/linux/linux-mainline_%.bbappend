FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SOURCES_K65:append:cubietruck = " \
	file://0001-cubietruck-Consistent-nodes-for-mmc-devices.patch \
	file://0001-sun4i-Lima-Mesa-Lima-Display-issues-on-Sunxi-Boards.patch \
"

SOURCES:append:cubietruck = " \
	file://0001-cubietruck-Consistent-nodes-for-mmc-devices.patch \
	file://0001-sun4i-Lima-Mesa-Lima-Display-issues-on-Sunxi-Boards.patch \
"

SRC_URI:append:cubietruck = " \
	file://wireguard.cfg \
"