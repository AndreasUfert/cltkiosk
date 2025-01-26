FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append:cubietruck = " \
    file://cubietruck/wg0.conf \
"
SRC_URI:append:intel-core2-32 = " \
    file://intel-core2-32/wg0.conf \
"

RDEPENDS:${PN}:append = " \
    resolvconf \
    iproute2 \
    iptables \
"

do_install:append(){
    install -m 0600 ${WORKDIR}/${MACHINE}/wg0.conf ${D}${sysconfdir}/wireguard/wg0.conf
}