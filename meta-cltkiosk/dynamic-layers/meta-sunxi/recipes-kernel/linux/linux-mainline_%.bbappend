FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SOURCES_K65:append = " \
	file://0001-cubietruck-Consistent-nodes-for-mmc-devices.patch \
	file://0001-Modify-MBUS-Driver-to-get-Mali-working-on-Sunxi-A20.patch \
	file://wireguard.cfg \
"

SOURCES:append = " \
	file://0001-cubietruck-Consistent-nodes-for-mmc-devices.patch \
	file://0001-Modify-MBUS-Driver-to-get-Mali-working-on-Sunxi-A20.patch \
	file://wireguard.cfg \
"