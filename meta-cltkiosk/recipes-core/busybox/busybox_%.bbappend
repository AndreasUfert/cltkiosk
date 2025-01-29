FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://ntpd.cfg"

SRC_URI += "file://99post-up"

do_install:append () {
	install -m 0755 ${WORKDIR}/99post-up ${D}${sysconfdir}/udhcpc.d/99post-up
}