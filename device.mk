LOCAL_PATH := device/xiaomi/tissot

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# define hardware platform
PRODUCT_PLATFORM := msm8953

# A/B support
AB_OTA_UPDATER := true

# A/B updater updatable partitions list. Keep in sync with the partition list
# with "_a" and "_b" variants in the device. Note that the vendor can add more
# more partitions to this list for the bootloader and radio.
AB_OTA_PARTITIONS += \
    boot \
    system 

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier

PRODUCT_PACKAGES += \
    bootctrl.msm8953 \
    update_engine_sideload

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# qcom standard decryption
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# tzdata
PRODUCT_PACKAGES += \
    tzdata_twrp

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service \
    android.hardware.boot@1.0-impl-wrapper.recovery \
    android.hardware.boot@1.0-impl-wrapper \
    android.hardware.boot@1.0-impl.recovery \
    bootctrl.msm8953 \
    bootctrl.msm8953.recovery \
    libcutils \
    libgptutils \
    libz


PRODUCT_HOST_PACKAGES += \
    libandroidicu

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Blacklist
PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \
    ro.bootimage.build.date.utc \
    ro.build.date.utc

# Overrides
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=tissot \
    BUILD_PRODUCT=tissot \
    TARGET_DEVICE=tissot

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.build.security_patch=2099-12-31
