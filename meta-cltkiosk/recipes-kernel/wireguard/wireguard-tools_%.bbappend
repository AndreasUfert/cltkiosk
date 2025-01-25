FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://wg0.conf"

RDEPENDS:${PN}:append = " \
    resolvconf \
    iproute2 \
    iptables \
"

do_install:append(){
    install -m 0600 ${WORKDIR}/wg0.conf ${D}${sysconfdir}/wireguard/wg0.conf
}