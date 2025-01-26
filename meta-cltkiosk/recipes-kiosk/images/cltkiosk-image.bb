SUMMARY = "Definition and configuration of the CLT kiosk image" 

require recipes-graphics/images/core-image-weston.bb

IMAGE_FSTYPES += "wic.xz"

IMAGE_FEATURES:append = " \
    read-only-rootfs \
"
IMAGE_FEATURES:remove = "splash"

CORE_IMAGE_EXTRA_INSTALL:append = " \
    epiphany \
    wpa-supplicant \
    wireguard-tools \
    tzdata \
"

CORE_IMAGE_EXTRA_INSTALL:cubietruck:append = " \
    linux-firmware-bcm43362 \
"

CORE_IMAGE_EXTRA_INSTALL:intel-core2-32:append = " \
    linux-firmware-rtl8723 \
"

do_sops() {
    # decrypt /etc/wireguard/wg0.conf
    sops -d -i ${IMAGE_ROOTFS}${sysconfdir}/wireguard/wg0.conf

    # decrypt /etc/wpa_supplicant.conf
    sops -d -i ${IMAGE_ROOTFS}${sysconfdir}/wpa_supplicant.conf
}
IMAGE_PREPROCESS_COMMAND += "do_sops;"
