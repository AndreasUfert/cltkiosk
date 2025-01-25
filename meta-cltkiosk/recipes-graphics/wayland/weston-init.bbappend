FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://kiosk.sh"

do_install:append() {
	install -d ${D}/${libexecdir}
	install -m 0755 ${WORKDIR}/kiosk.sh ${D}/${libexecdir}
}
