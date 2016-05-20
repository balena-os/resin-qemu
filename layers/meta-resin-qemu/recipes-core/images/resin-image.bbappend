# Install grub
BURN_GRUB_qemuall = "1"

IMAGE_FSTYPES_append_qemuall = " resin-sdcard"

# Customize resin-sdcard
RESIN_IMAGE_BOOTLOADER_qemuall = "grub"
RESIN_BOOT_PARTITION_FILES_qemuall = " \
    ${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin:/${KERNEL_IMAGETYPE} \
    grub:/grub/ \
    grub/i386-pc:/grub/i386-pc/ \
    "

#
# Deploy a bundle of files for qemu machines
#
EXTRA_IMAGEDEPENDS_append_qemuall = " resin-runqemu"
RESIN_RUNQEMUDIR = "${DEPLOY_DIR_IMAGE}/resin-runqemu"
RESIN_BUNDLEDIR = "${DEPLOY_DIR_IMAGE}/resin-${MACHINE}"
deploy_image_in_bundle() {
    rm -rf ${RESIN_BUNDLEDIR}
    mkdir -p ${RESIN_BUNDLEDIR}

    # Deploy image
    cp -rL ${DEPLOY_DIR_IMAGE}/resin-image-${MACHINE}.resin-sdcard ${RESIN_BUNDLEDIR}/resin-image-${MACHINE}.hddimg

    # Deploy runqemu scripts
    cp -r ${RESIN_RUNQEMUDIR}/* ${RESIN_BUNDLEDIR}
}
IMAGE_POSTPROCESS_COMMAND_append_qemuall = " deploy_image_in_bundle; "
