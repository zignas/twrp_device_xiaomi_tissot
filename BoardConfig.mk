#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

# Default device path
DEVICE_PATH := device/xiaomi/tissot

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := $(TARGET_CPU_VARIANT)
TARGET_2ND_CPU_VARIANT_RUNTIME := $(TARGET_CPU_VARIANT_RUNTIME)

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8953
TARGET_NO_BOOTLOADER := true

# GPT Utils
BOARD_PROVIDES_GPTUTILS := true

# Kernel
BOARD_KERNEL_CMDLINE := \
    androidboot.hardware=qcom \
    msm_rtb.filter=0x237 \
    ehci-hcd.park=3 \
    lpm_levels.sleep_disabled=1 \
    androidboot.bootdevice=7824900.sdhci \
    earlycon=msm_hsl_uart,0x78af000 \
    androidboot.selinux=permissive \
    buildvariant=eng
    
#BOARD_KERNEL_CMDLINE += loop.max_part=7
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_PAGESIZE := 2048
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)

# Platform
TARGET_BOARD_PLATFORM := $(TARGET_BOOTLOADER_BOARD_NAME)
TARGET_BOARD_PLATFORM_GPU := qcom-adreno506
QCOM_BOARD_PLATFORMS += $(TARGET_BOARD_PLATFORM)

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := false
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Init
TARGET_INIT_VENDOR_LIB := libinit_$(TARGET_DEVICE)
TARGET_RECOVERY_DEVICE_MODULES := libinit_$(TARGET_DEVICE)

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true

# TWRP specific build flags
TW_USE_TOOLBOX := true
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_RESETPROP := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 85
TW_THEME := portrait_hdpi
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    libicuuc \
    libion \
    libprocinfo \
    libxml2

TW_RECOVERY_ADDITIONAL_RELINK_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libicuuc.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libprocinfo.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so
    

TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TW_NO_SCREEN_BLANK := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.product;ro.build.fingerprint=ro.system.build.fingerprint;ro.build.version.incremental;ro.product.device=ro.product.system.device;ro.product.model=ro.product.system.model;ro.product.name=ro.product.system.name"

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.base@1.0 \
    ashmemd_aidl_interface-cpp \
    libashmemd_client \
    libcap \
    libion \
    libpcrecpp \
    libxml2
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.base@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/ashmemd_aidl_interface-cpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libashmemd_client.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libcap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpcrecpp.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# Encryption
PLATFORM_VERSION := 16.1.0
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
TW_INCLUDE_CRYPTO := true
BOARD_USES_METADATA_PARTITION := false
BOARD_USES_QCOM_FBE_DECRYPTION := true

# Extras
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop

# TWRP specific build flags
BOARD_SUPPRESS_SECURE_ERASE := true
USE_RECOVERY_INSTALLER := true
RECOVERY_INSTALLER_PATH := bootable/recovery/installer
TW_EXCLUDE_TWRPAPP := true
TW_INCLUDE_REPACKTOOLS := true
TW_HAS_EDL_MODE := false
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
