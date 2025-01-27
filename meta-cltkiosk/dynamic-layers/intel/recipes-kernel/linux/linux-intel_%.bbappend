FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
	file://wireguard.cfg \
	file://rtl8723bs.cfg \
"