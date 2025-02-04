SUMMARY = "Definition and configuration of the CLT kiosk image" 

require recipes-graphics/images/core-image-weston.bb

IMAGE_FSTYPES += "wic.xz"

IMAGE_FEATURES:append = " \
    read-only-rootfs \
"
IMAGE_FEATURES:remove:intel-core2-32 = "splash"
IMAGE_FEATURES:remove:intel-corei7-64 = "splash"

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

CORE_IMAGE_EXTRA_INSTALL:append:intel-corei7-64 = " \
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


# Onda V820w has a 64 bit CPU but UEFI can only boot 32 bit EFI binaries
# so we need a multiconfig dependency to grub-efi in intel-core2-32
# and include the deployed ia32 EFI binary in intel-corei7-64's ESP

FROM_MULTICONFIG:intel-corei7-64 = "${BB_CURRENT_MC}"
TO_MULTICONFIG:intel-corei7-64 = "intel-core2-32"
do_image_wic:intel-corei7-64[mcdepends] += "mc:${FROM_MULTICONFIG}:${TO_MULTICONFIG}:grub-efi:do_deploy"

TO_MACHINE:intel-corei7-64 = "intel-core2-32"
IMAGE_EFI_BOOT_FILES:intel-corei7-64 += "${TOPDIR}/tmp-${TO_MULTICONFIG}/deploy/images/${TO_MACHINE}/grub-efi-bootia32.efi;EFI/BOOT/bootia32.efi"
