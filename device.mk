#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/itel/P13001L
KERNEL_PATH := $(DEVICE_PATH)-kernel

# A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    dtbo \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=$(BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=$(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    checkpoint_gc \
    otapreopt_script \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_VIRTUAL_AB_COMPRESSION_METHOD := lz4

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
PRODUCT_CHARACTERISTICS := tablet

# Allow userspace reboots
$(call inherit-product, $(SRC_TARGET_DIR)/product/userspace_reboot.mk)

# Audio
$(call soong_config_set,android_hardware_audio,run_64bit,true)

PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl:64 \
    android.hardware.audio.effect@7.0-impl:64 \
    android.hardware.audio.service \
    android.hardware.bluetooth.audio-impl:64 \
    android.hardware.soundtrigger@2.3-impl:64 \
    audio.bluetooth.default:64 \
    audio.primary.default:64 \
    audio.r_submix.default:64 \
    audio.usb.default:64 \
    audio_policy.stub:64 \
    audioclient-types-aidl-cpp.vendor:64 \
    libalsautils:64 \
    libaudiofoundation.vendor:64 \
    libaudiopreprocessing:64 \
    libaudioroute.vendor:64 \
    libbluetooth_audio_session:64 \
    libbundlewrapper:64 \
    libdownmix:64 \
    libdynproc:64 \
    libeffectproxy:64 \
    libhapticgenerator:64 \
    libldnhncr:64 \
    libnbaio_mono:64 \
    libopus.vendor:64 \
    libprocessgroup.vendor:64 \
    libreverbwrapper:64 \
    libtinycompress:64 \
    MtkInCallService

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc) \
    $(LOCAL_PATH)/configs/audio/audio_param/SpeechVol_AudioParam.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_param/SpeechVol_AudioParam.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usb_audio_policy_configuration.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth-service.mediatek \
    vendor.mediatek.hardware.bluetooth.audio@2.1.vendor:64 \
    vendor.mediatek.hardware.bluetooth.audio@2.2.vendor:64

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot-service.default_recovery \
    com.android.hardware.boot

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.common@1.0.vendor \
    android.hardware.camera.device@3.6.vendor \
    android.hardware.camera.provider@2.6.vendor \
    libdng_sdk.vendor \
    libexif.vendor \
    libexpat.vendor \
    libpiex \
    libpng.vendor

# CAS
PRODUCT_PACKAGES += \
    android.hardware.cas@1.2-service-lazy

# Control groups/Task profiles
PRODUCT_COPY_FILES += \
    system/core/libprocessgroup/profiles/cgroups.json:$(TARGET_COPY_OUT_VENDOR)/etc/cgroups.json \
    system/core/libprocessgroup/profiles/task_profiles.json:$(TARGET_COPY_OUT_VENDOR)/etc/task_profiles.json

# Dalvik configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@4.0.vendor \
    android.hardware.graphics.composer@2.3-service \
    android.hardware.graphics.mapper@4.0.vendor \
    android.hardware.memtrack-service.mediatek \
    ANGLE \
    libdrm.vendor \
    libion.vendor \
    libui.vendor

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Engineering Mode
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/privapp-permissions-com.mediatek.engineermode.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-com.mediatek.engineermode.xml

# FastbootD
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service \
    libgatekeeper.vendor

# GNSS
PRODUCT_PACKAGES += \
    android.hardware.gnss-V1-ndk.vendor \
    android.hardware.gnss.measurement_corrections@1.1.vendor \
    android.hardware.gnss.visibility_control@1.0.vendor \
    android.hardware.gnss@1.1.vendor \
    android.hardware.gnss@2.1.vendor \
    libcurl.vendor

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.mediatek \
    android.hardware.health-service.mediatek-recovery

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0 \
    android.hidl.allocator@1.0.vendor \
    android.hidl.base@1.0 \
    android.hidl.base@1.0.vendor \
    libhidlmemory.vendor \
    libhidltransport \
    libhidltransport.vendor \
    libhwbinder \
    libhwbinder.vendor

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Inherit common MediaTek IMS
$(call inherit-product, vendor/mediatek/ims/ims.mk)

# Init files
PRODUCT_PACKAGES += \
    fstab.mt8781 \
    fstab.mt8781.vendor_ramdisk \
    init_connectivity.rc \
    init.connectivity.common.rc \
    init.connectivity.rc \
    init.insmod.sh \
    init.insmod.mt6789.cfg \
    init.modem.rc \
    init.mt6789.power.rc \
    init.mt6789.rc \
    init.mt8781.rc \
    init.mt6789.usb.rc \
    init.mtkgki.rc \
    init.project.rc \
    init.recovery.usb.rc \
    init.sensor_2_0.rc \
    ueventd.mt6789.rc

# Kernel
PRODUCT_COPY_FILES += \
    $(KERNEL_PATH)/Image.gz:kernel

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint-V4-ndk.vendor:64 \
    android.hardware.security.rkp-V3-ndk.vendor:64 \
    android.hardware.security.secureclock-V1-ndk.vendor:64 \
    android.hardware.security.sharedsecret-V1-ndk.vendor:64 \
    libcppbor_external.vendor:64

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.keystore.app_attest_key.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.keystore.app_attest_key.xml

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light-service.lineage

# Linker config
PRODUCT_VENDOR_LINKER_CONFIG_FRAGMENTS += \
    $(LOCAL_PATH)/configs/linker.config.json

# Media
PRODUCT_PACKAGES += \
    android.hardware.media.c2@1.0.vendor:64 \
    android.hardware.media.c2@1.1.vendor:64 \
    android.hardware.media.c2@1.2.vendor:64 \
    libavservices_minijail_vendor:64 \
    libchrome.vendor:64 \
    libcodec2_hidl@1.2.vendor:64 \
    libcodec2_hidl_plugin:64 \
    libcodec2_soft_common.vendor:64 \
    libcodec2_vndk.vendor:64 \
    libeffects:64 \
    libeffectsconfig.vendor:64 \
    libflatbuffers-cpp.vendor:64 \
    libminijail:64 \
    libminijail.vendor:64 \
    libsfplugin_ccodec_utils.vendor:64 \
    libstagefright_softomx_plugin.vendor:64

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/media,$(TARGET_COPY_OUT_VENDOR)/etc) \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/seccomp,$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy)

# Neural networks
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.0.vendor \
    android.hardware.neuralnetworks@1.3.vendor \
    libtextclassifier_hash.vendor

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

PRODUCT_PACKAGES += \
    FrameworksResTarget \
    OpenDeltaOverlayMT6789 \
    SettingsProviderResTarget \
    SettingsResTarget \
    SystemUIResTarget \
    TetheringConfigTarget \
    WifiResTarget

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.faketouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.faketouch.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.dynamic.head_tracker.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.dynamic.head_tracker.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnel_migration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnel_migration.xml \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.opengles.deqp.level.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.verified_boot.xml \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2021-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr \
    android.hardware.power@1.3.vendor \
    libmtkperf_client \
    libmtkperf_client_vendor \
    vendor.mediatek.hardware.mtkpower@1.0.vendor \
    vendor.mediatek.hardware.mtkpower@1.1.vendor \
    vendor.mediatek.hardware.mtkpower@1.2-service.stub

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/perf,$(TARGET_COPY_OUT_VENDOR)/etc) \
    $(LOCAL_PATH)/configs/power/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Properties
include $(LOCAL_PATH)/vendor_logtag.mk

# Public Libraries
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/public.libraries.txt:$(TARGET_COPY_OUT_VENDOR)/etc/public.libraries.txt

# Radio
PRODUCT_PACKAGES += \
    android.hardware.radio.config@1.3.vendor \
    android.hardware.radio@1.6.vendor

# Secure Element
PRODUCT_PACKAGES += \
    android.hardware.secure_element@1.2.vendor

# Sensors
PRODUCT_PACKAGES += \
    android.frameworks.sensorservice@1.0:64 \
    android.frameworks.sensorservice@1.0.vendor:64 \
    android.hardware.sensors-service.multihal \
    android.hardware.sensors@1.0.vendor:64 \
    android.hardware.sensors@2.0-ScopedWakelock.vendor:64 \
    android.hardware.sensors@2.0-subhal-impl-1.0 \
    android.hardware.sensors@2.1.vendor:64 \
    libsensorndkbridge:64

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Shims
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-convert-shared.vendor \
    libdumpstateutil.vendor \
    libhidlbase_shim \
    libjsoncpp.vendor \
    liblz4.vendor \
    libmemunreachable.vendor \
    libnetutils.vendor \
    libpower.vendor \
    libsqlite.vendor \
    libziparchive.vendor

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 31

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/mediatek \
    hardware/mediatek/libmtkperf_client

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.mediatek

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal/thermal_info_config.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json

# USB
$(call soong_config_set,android_hardware_mediatek_usb,audio_accessory_supported,true)

PRODUCT_PACKAGES += \
    android.hardware.usb-service.mediatek \
    android.hardware.usb.gadget-service.mediatek

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservice \
    vndservicemanager

# VNDK
PRODUCT_PACKAGES += \
    libbase_shim \
    libbinder-v31 \
    libbinder-v32 \
    libcamera_metadata_shim \
    libhidlbase-v31 \
    libhidlbase-v32 \
    libprocessgroup_shim \
    libstagefright_foundation-v33 \
    libunwindstack.vendor \
    libutilscallstack.vendor \
    libutils-v31 \
    libutils-v32

# Wi-Fi
PRODUCT_PACKAGES += \
    android.hardware.tetheroffload.config@1.0.vendor \
    android.hardware.tetheroffload.control@1.0.vendor \
    android.hardware.tetheroffload.control@1.1.vendor \
    android.hardware.wifi-service \
    hostapd \
    lib_driver_cmd_mt66xx \
    libkeystore-engine-wifi-hidl:64 \
    libkeystore-wifi-hidl:64 \
    libwifi-hal-wrapper \
    wpa_supplicant

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/wifi/,$(TARGET_COPY_OUT_VENDOR)/etc/wifi)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/itel/P13001L/P13001L-vendor.mk)
