#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet.mk)

# Inherit from P13001L device
$(call inherit-product, device/itel/P13001L/device.mk)

PRODUCT_NAME := lineage_P13001L
PRODUCT_DEVICE := P13001L
PRODUCT_MANUFACTURER := itel
PRODUCT_BRAND := Itel
PRODUCT_MODEL := itel P13001L

PRODUCT_GMS_CLIENTID_BASE := android-transsion

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sys_mssi_t_64_cn_armv82-user 14 UP1A.231005.007 1728750305 release-keys" \
    BuildFingerprint=Itel/P13001L-GL/P13001L:14/UP1A.231005.007/1728750305:user/release-keys \
    DeviceName=P13001L \
    DeviceProduct=P13001L \
    SystemDevice=P13001L \
    SystemName=P13001L

PERF_ANIM_OVERRIDE := true

WITH_GMS := false

# Time
LINEAGE_VERSION_APPEND_TIME_OF_DAY := true