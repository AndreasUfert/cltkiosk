SUMMARY = "Definition and configuration of the CLT kiosk image" 

require recipes-graphics/images/core-image-weston.bb

IMAGE_FSTYPES += "wic.xz"

IMAGE_FEATURES:append = " \
    read-only-rootfs \
"
IMAGE_FEATURES:remove:intel-core2-32 = "splash"

CORE_IMAGE_EXTRA_INSTALL:append = " \
    wpa-supplicant \
    wireguard-tools \
    tzdata \
    wpewebkit \
    cog \
"

CORE_IMAGE_EXTRA_INSTALL:append:cubietruck = " \
    linux-firmware-bcm43362 \
"

CORE_IMAGE_EXTRA_INSTALL:append:intel-core2-32 = " \
    linux-firmware-rtl8723 \
    efibootmgr \
"

do_sops() {
    # decrypt /etc/wireguard/wg0.conf
    sops -d -i ${IMAGE_ROOTFS}${sysconfdir}/wireguard/wg0.conf

    # decrypt /etc/wpa_supplicant.conf
    sops -d -i ${IMAGE_ROOTFS}${sysconfdir}/wpa_supplicant.conf
}
IMAGE_PREPROCESS_COMMAND += "do_sops;"
