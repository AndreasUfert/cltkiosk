SUMMARY = "Definition and configuration of the CLT kiosk image" 

require recipes-graphics/images/core-image-weston.bb

IMAGE_FEATURES:append = " \
    read-only-rootfs \
"
IMAGE_FEATURES:remove = "splash"

IMAGE_INSTALL:append = " \
    epiphany \
    wpa-supplicant \
    wireguard-tools \
    tzdata \
"

IMAGE_INSTALL:cubietruck:append = " \
    linux-firmware-bcm43362 \
"

do_sops() {
    # decrypt /etc/wireguard/wg0.conf
    sops -d -i ${IMAGE_ROOTFS}${sysconfdir}/wireguard/wg0.conf

    # decrypt /etc/wpa_supplicant.conf
    sops -d -i ${IMAGE_ROOTFS}${sysconfdir}/wpa_supplicant.conf
}
IMAGE_PREPROCESS_COMMAND += "do_sops;"
