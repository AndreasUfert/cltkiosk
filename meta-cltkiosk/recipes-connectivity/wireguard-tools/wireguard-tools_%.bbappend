FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://wg-quick-init.sh"

SRC_URI:append:cubietruck = " \
    file://cubietruck/wg0.conf \
"
SRC_URI:append:intel-core2-32 = " \
    file://intel-core2-32/wg0.conf \
"

inherit update-rc.d

INITSCRIPT_NAME = "wg-quick-init"
INITSCRIPT_PARAMS = "start 05 1 2 3 4 5 . stop 75 0 6 ."

RDEPENDS:${PN}:append = " \
    resolvconf \
    iproute2 \
    iptables \
"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/wg-quick-init.sh ${D}${sysconfdir}/init.d/wg-quick-init

    install -m 0600 ${WORKDIR}/${MACHINE}/wg0.conf ${D}${sysconfdir}/wireguard/wg0.conf
}
