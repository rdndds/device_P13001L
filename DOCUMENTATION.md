# Advan Tab V8 (T812) Device Tree Documentation

## Table of Contents
1. [Overview](#overview)
2. [Device Specifications](#device-specifications)
3. [Architecture](#architecture)
4. [Directory Structure](#directory-structure)
5. [Build Configuration](#build-configuration)
6. [Device-Specific Features](#device-specific-features)
7. [Kernel & Modules](#kernel--modules)
8. [Proprietary Files](#proprietary-files)
9. [Building Instructions](#building-instructions)
10. [Audio Configuration](#audio-configuration)
11. [Power Profile](#power-profile)
12. [Overlays & Customization](#overlays--customization)
13. [SELinux Policies](#selinux-policies)
14. [OTA Updates](#ota-updates)
15. [Troubleshooting](#troubleshooting)

---

## Overview

This is the device-specific tree for the **Advan Tab V8** (codename: **T812**), an 8.4-inch tablet powered by the MediaTek MT6789 (Helio G99) chipset. This tree inherits from the `mt6789-common` device tree and adds T812-specific configurations.

### Key Information
- **Codename**: T812
- **Marketing Name**: Advan Tab V8
- **Model Number**: 8004
- **Manufacturer**: ADVAN
- **OEM Name**: ADVAN_TAB_V8
- **Alternate Name**: iPlay60_mini_Pro (OEM reference)
- **LineageOS Target**: `lineage_T812`

### Related Repositories
- **Device Common Tree**: `device/advan/mt6789-common`
- **Vendor Blobs (Common)**: `vendor/advan/mt6789-common`
- **Vendor Blobs (T812)**: `vendor/advan/T812`
- **Kernel**: `device/advan/T812-kernel` (prebuilt)

---

## Device Specifications

### Hardware Overview

| Component | Specification |
|-----------|--------------|
| **SoC** | MediaTek Helio G99 (MT6789) |
| **CPU** | Octa-core (2x Cortex-A76 @ 2.20 GHz + 6x Cortex-A55 @ 2.0 GHz) |
| **GPU** | Mali-G57 MC2 |
| **Memory** | 8GB RAM (LPDDR4X) |
| **Storage** | 128GB UFS 2.2 |
| **MicroSD** | MicroSDXC (expandable) |
| **Display** | 8.4" IPS LCD, 1920 x 1200 pixels (WUXGA), 16:10 ratio |
| **Screen Density** | 280 DPI |
| **Rear Camera** | 13.1 MP, f/2.0, 0.89µm pixel size, AF |
| **Front Camera** | 5 MP, f/2.0, 1.12µm pixel size |
| **Battery** | Non-removable 5500 mAh |
| **Dimensions** | 202.7 x 126 x 7.9 mm |
| **Weight** | ~350g (estimated) |
| **Android Version** | 14 (shipped) |
| **Build Fingerprint** | ADVAN_TAB_V8:14/UP1A.231005.007/1729758888 |

### Connectivity
- **Wi-Fi**: 802.11 a/b/g/n/ac (dual-band)
- **Bluetooth**: 5.2
- **GPS**: A-GPS, GLONASS, Beidou
- **Cellular**: 4G LTE (GSM/WCDMA/LTE)
- **SIM**: Dual SIM (nano-SIM)
- **USB**: Type-C, USB 2.0, OTG support

### Sensors
- Accelerometer
- Gyroscope
- Compass (Magnetometer)
- Ambient Light Sensor
- Proximity Sensor
- Step Counter/Detector

### Audio
- Dual speakers (stereo)
- Smart PA (Awinic amplifier)
- 3.5mm headphone jack
- 4 microphones

---

## Architecture

### Platform Architecture
- **64-bit Only**: Core device runs exclusively in 64-bit mode
- **ARM64 ISA**: ARMv8.2-A with DotProd extensions
- **Base Platform**: MediaTek MT6789 (mt6789)
- **Board Platform**: `mt6789`
- **Telephony**: Full telephony support (GSM/LTE)
- **Form Factor**: Tablet

### Inheritance Chain
```
lineage_T812.mk
  ├─> device/advan/T812/device.mk
  │     └─> device/advan/mt6789-common/common.mk
  │           ├─> A/B OTA system
  │           ├─> Dynamic partitions
  │           ├─> Hardware HALs (Audio, Display, Power, etc.)
  │           └─> MediaTek hardware support
  ├─> vendor/lineage/config/common_full_tablet.mk
  └─> $(SRC_TARGET_DIR)/product/core_64_bit_only.mk
```

---

## Directory Structure

```
android_device_advan_T812/
├── configs/                       # Device-specific configurations
│   ├── audio/                     # Audio configuration
│   │   └── audio_policy_configuration.xml
│   └── properties/                # Device properties
│       └── vendor.prop            # Vendor-specific properties
├── overlay/                       # Device-specific overlays
│   └── FrameworksResOverlayT812/  # Framework resource overlay
│       ├── Android.bp             # Build definition
│       ├── AndroidManifest.xml    # Overlay manifest
│       └── res/
│           └── xml/
│               └── power_profile.xml  # Battery power profile
├── sepolicy/                      # SELinux policies
│   └── vendor/                    # Vendor policy additions
│       ├── file_contexts          # File security contexts
│       ├── hal_drm_widevine.te    # Widevine DRM policies
│       └── hal_keymint_default.te # Keymint HAL policies
├── Android.bp                     # Blueprint build config
├── AndroidProducts.mk             # Product definition list
├── BoardConfig.mk                 # Board-specific build config
├── device.mk                      # Device product config
├── extract-files.py               # Blob extraction script
├── lineage_T812.mk                # LineageOS product makefile
├── proprietary-files.txt          # Proprietary blob list (1779 files)
├── proprietary-firmware.txt       # Firmware images list (13 files)
├── setup-makefiles.py             # Vendor makefile generator
└── README.md                      # Basic device info
```

### Kernel Directory (T812-kernel/)
```
android_device_advan_T812-kernel/
├── dtb/                           # Device tree binaries
├── dtbo.img                       # Device tree overlay image (8 MB)
├── Image.gz                       # Compressed kernel image (~19 MB)
├── kernel-headers/                # Kernel header files
└── modules/                       # Kernel modules
    ├── vendor_dlkm/               # Vendor DLKM modules (168 modules)
    │   ├── *.ko                   # Kernel module objects
    │   └── modules.load           # Module load order
    └── vendor_ramdisk/            # Vendor ramdisk modules
        ├── *.ko                   # Early boot modules
        ├── modules.load           # Module load order
        └── modules.load.recovery  # Recovery module list
```

---

## Build Configuration

### BoardConfig.mk

This file defines T812-specific build configurations and inherits from `mt6789-common`.

#### Key Configurations

##### Boot Image
```makefile
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
```
- Device tree blobs are included directly in boot.img
- Enables proper hardware initialization at boot

##### Display
```makefile
TARGET_SCREEN_DENSITY := 280
```
- Sets screen DPI to 280 for proper UI scaling on 8.4" display

##### Kernel
```makefile
TARGET_NO_KERNEL_OVERRIDE := true
```
- Uses prebuilt kernel from `T812-kernel` directory
- Kernel path: `KERNEL_PATH := $(DEVICE_PATH)-kernel`

##### Kernel Modules
The device loads kernel modules in three stages:

1. **Vendor Ramdisk Modules**: Loaded during early boot
   - Listed in `modules/vendor_ramdisk/modules.load`
   - Essential drivers (bootprof, mrdump, pinctrl, etc.)

2. **Recovery Modules**: Additional modules for recovery
   - Listed in `modules/vendor_ramdisk/modules.load.recovery`
   - Merged with vendor ramdisk modules

3. **Vendor DLKM Modules**: Loaded after system boot
   - Listed in `modules/vendor_dlkm/modules.load`
   - 168 modules for hardware support

##### OTA Assert
```makefile
TARGET_OTA_ASSERT_DEVICE := ADVAN_TAB_V8,iPlay60_mini_Pro
```
- OTA updates will only install on devices with these identifiers
- Prevents accidental flashing to incompatible devices

---

### device.mk

This file defines the T812 product configuration.

#### Inheritance
```makefile
$(call inherit-product, device/advan/mt6789-common/common.mk)
```
- Inherits all common MT6789 configurations
- Adds T812-specific overrides

#### Device-Specific Additions

##### Audio Configuration
```makefile
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml
```
- Overrides common audio policy with T812-specific configuration
- Disables earpiece (tablet doesn't have one)
- Configures dual speaker setup

##### Prebuilt Kernel
```makefile
PRODUCT_COPY_FILES += \
    $(KERNEL_PATH)/Image.gz:kernel
```
- Copies prebuilt kernel to ROM package
- Kernel is not compiled from source

##### Framework Overlay
```makefile
PRODUCT_PACKAGES += \
    FrameworksResOverlayT812
```
- Adds device-specific resource overlay
- Includes power profile for battery estimation

##### Soong Namespaces
```makefile
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
```
- Enables local Blueprint (Soong) modules

---

### lineage_T812.mk

This is the main LineageOS product makefile.

#### Product Identity
```makefile
PRODUCT_NAME := lineage_T812
PRODUCT_DEVICE := T812
PRODUCT_MANUFACTURER := ADVAN
PRODUCT_BRAND := ADVAN
PRODUCT_MODEL := 8004
```

#### Tablet Configuration
```makefile
$(call inherit-product, vendor/lineage/config/common_full_tablet.mk)
```
- Enables tablet-specific features
- Sets tablet UI optimizations
- Configures launcher for tablet mode

#### GMS Client ID
```makefile
PRODUCT_GMS_CLIENTID_BASE := android-advandigital
```
- Used for Google services identification

#### Build Fingerprint
```makefile
BuildFingerprint=ADVAN/ADVAN_TAB_V8/ADVAN_TAB_V8:14/UP1A.231005.007/1729758888:user/release-keys
```
- Matches stock firmware fingerprint
- Ensures compatibility with vendor blobs
- Passes SafetyNet/Play Integrity checks

---

## Device-Specific Features

### Tablet Optimizations
1. **No Earpiece**: Audio policy configured for speaker-only calls
2. **Landscape First**: UI optimized for horizontal orientation
3. **Tablet Launcher**: Uses tablet-optimized launcher layout
4. **Split Screen**: Enhanced multi-window support

### Hardware Features

#### Smart PA Audio
- **Amplifier**: Awinic Smart PA chip
- **Library**: `libawinic_mtk_aurisys.so`
- **Configuration**: Custom DSP parameters in `smartpa_param/`
- **Features**: Dynamic range control, thermal protection

#### Camera System
- **ISP**: MediaTek MT6789 ISP
- **Provider**: Camera HAL 2.6 (MediaTek implementation)
- **Features**:
  - Autofocus (rear camera)
  - Face detection
  - HDR mode
  - Video stabilization

#### Trusted Execution Environment
- **TEE**: TrustKernel TEE
- **Gatekeeper**: `ro.hardware.gatekeeper=trustkernel`
- **Keymaster**: `ro.hardware.kmsetkey=trustkernel`
- **Security**: Hardware-backed keystore
- **DRM**: Widevine L1 support (if certified)

---

## Kernel & Modules

### Prebuilt Kernel
- **Source**: `device/advan/T812-kernel/Image.gz`
- **Size**: ~19 MB compressed
- **Version**: Linux 5.15.x (MediaTek)
- **Format**: GZip compressed kernel image
- **Boot Header**: Version 4

### Device Tree
- **DTB Directory**: `device/advan/T812-kernel/dtb/`
- **DTBO Image**: `dtbo.img` (8 MB)
- **Format**: Flattened Device Tree (FDT)
- **Purpose**: Hardware description for bootloader/kernel

### Kernel Modules

#### Vendor Ramdisk Modules (Early Boot)
Essential modules loaded during early boot stage:

```
mkp.ko                    # Memory protection
bootprof.ko               # Boot profiling
dbgtop-drm.ko            # Debug top DRM
mrdump.ko                 # Memory dump (ramdump)
mtk_disp_notify.ko       # Display notifications
aee_aed.ko               # Android Exception Engine
aee_hangdet.ko           # Hang detection
monitor_hang.ko          # System hang monitoring
mtk_printk_ctrl.ko       # Kernel log control
log_store.ko             # Log storage
nvmem_mtk-devinfo.ko     # Device info NVMEM
mtk_wdt.ko               # Watchdog timer
sec-rng.ko               # Secure random number generator
device-apc-*.ko          # Device access permission control
hwinfo.ko                # Hardware info
pinctrl-*.ko             # Pin control drivers
```

#### Vendor DLKM Modules (Post-Boot)
**168 kernel modules** loaded after system initialization, including:

- **Display**: DRM/KMS drivers, GPU drivers (Mali)
- **Media**: Video codecs, camera ISP, image processing
- **Audio**: Sound card drivers, audio DSP
- **Connectivity**: Wi-Fi, Bluetooth, modem drivers
- **Sensors**: Accelerometer, gyro, compass drivers
- **Storage**: UFS controller, SD card reader
- **Power**: PMIC drivers, charging, thermal management
- **Security**: TEE drivers, crypto accelerators

### Module Loading
Modules are loaded in specific order defined in:
- `modules/vendor_ramdisk/modules.load` (early boot)
- `modules/vendor_ramdisk/modules.load.recovery` (recovery mode)
- `modules/vendor_dlkm/modules.load` (normal boot)

---

## Proprietary Files

### Overview
The T812 device requires **1792 total proprietary files**:
- **1779 files**: Device-specific blobs (`proprietary-files.txt`)
- **13 files**: Firmware images (`proprietary-firmware.txt`)

### Firmware Images (proprietary-firmware.txt)

These are critical A/B firmware partitions:

| File | Partition | Purpose | Pinned |
|------|-----------|---------|--------|
| dpm.img | dpm1/dpm2 | DPM firmware (Digital Power Manager) | No |
| gz.img | gz1/gz2 | ARM TrustZone (Geniekey) | No |
| lk.img | lk1/lk2 | LK bootloader (Little Kernel) | Yes |
| mcupm.img | mcupm1/mcupm2 | MCU Power Management firmware | No |
| md1img.img | md1img | Modem firmware (4G LTE) | No |
| pi_img.img | pi_img | Preloader info image | No |
| scp.img | scp1/scp2 | System Control Processor firmware | No |
| spmfw.img | spmfw | SPM firmware (System Power Manager) | No |
| sspm.img | sspm1/sspm2 | Sensor Subsystem Power Manager | No |
| tee.img | tee1/tee2 | TEE firmware (TrustKernel) | Yes |

**Note**: Pinned images (lk.img, tee.img) have SHA-1 checksums to ensure specific versions are used.

### Proprietary Blobs Categories

#### Audio (Smart PA)
```
vendor/lib64/libawinic_mtk_aurisys.so      # Awinic Smart PA library
vendor/etc/audio_device.xml                # Audio device configuration
vendor/etc/aurisys_config.xml              # Aurisys framework config
vendor/etc/smartpa_param/AW_DSP.bin        # Smart PA DSP firmware
```

#### Camera
```
vendor/bin/hw/camerahalserver              # Camera HAL server
vendor/lib64/hw/android.hardware.camera.provider@2.6-impl-mediatek.so
vendor/lib64/libmtkcam_*.so                # MediaTek camera libraries
vendor/lib64/libcam.*.so                   # Camera subsystem libs
```

#### Display & Graphics
```
vendor/lib64/hw/android.hardware.graphics.mapper@4.0-impl-arm.so
vendor/lib64/libmali-bifrost-g57mc2-*.so   # Mali GPU driver
vendor/lib64/hw/hwcomposer.mt6789.so       # Hardware composer
```

#### Media Codecs
```
vendor/lib64/libcodec2_hidl@1.2.so         # Codec2 HAL
vendor/lib64/libMtkOmxVdec.so              # Video decoder
vendor/lib64/libMtkOmxVenc.so              # Video encoder
vendor/lib64/libvcodec_*.so                # Video codec libraries
```

#### RIL & Telephony
```
vendor/bin/hw/android.hardware.radio@1.6-radio-service-mediatek
vendor/lib64/libmtk-ril.so                 # MediaTek RIL
vendor/lib64/libril-*.so                   # RIL libraries
```

#### Sensors
```
vendor/lib64/hw/android.hardware.sensors@2.X-subhal-mediatek.so
vendor/lib64/libsensorlistener.so
```

#### TEE & Security
```
vendor/bin/hw/android.hardware.security.keymint-service.trustkernel
vendor/bin/hw/android.hardware.drm-service.clearkey
vendor/lib64/libteei_daemon_vfs.so         # TrustKernel TEE
```

#### Wi-Fi & Bluetooth
```
vendor/bin/hw/android.hardware.wifi@1.0-service-mediatek
vendor/firmware/WIFI_*.bin                 # Wi-Fi firmware
vendor/firmware/BT_FW.bin                  # Bluetooth firmware
```

### Blob Fixups

The `extract-files.py` script applies automatic fixups:

```python
# Fix Keymint HAL dependencies
'vendor/bin/hw/android.hardware.security.keymint-service.trustkernel':
    .replace_needed('...keymint-V1-ndk_platform.so', '...keymint-V4-ndk.so')
    .add_needed('android.hardware.security.rkp-V3-ndk.so')

# Fix camera sensor provider
'vendor/lib64/mt6789/libcam.utils.sensorprovider.so':
    .replace_needed('libsensorndkbridge.so', 'android.hardware.sensors@1.0-convert-shared.so')
```

---

## Building Instructions

### Prerequisites
- LineageOS 21 build environment
- 16GB+ RAM (32GB recommended)
- 400GB+ free disk space
- Ubuntu 20.04/22.04 or compatible Linux distro

### Step-by-Step Build Guide

#### 1. Initialize Repo
```bash
mkdir ~/lineage
cd ~/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
```

#### 2. Create Local Manifest
Create `.repo/local_manifests/advan_t812.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <!-- Device Trees -->
  <project name="your-org/android_device_advan_mt6789-common"
           path="device/advan/mt6789-common"
           remote="github"
           revision="lineage-21" />
  
  <project name="your-org/android_device_advan_T812"
           path="device/advan/T812"
           remote="github"
           revision="lineage-21" />
  
  <project name="your-org/android_device_advan_T812-kernel"
           path="device/advan/T812-kernel"
           remote="github"
           revision="lineage-21" />
  
  <!-- Vendor Blobs -->
  <project name="your-org/android_vendor_advan_mt6789-common"
           path="vendor/advan/mt6789-common"
           remote="github"
           revision="lineage-21" />
  
  <project name="your-org/android_vendor_advan_T812"
           path="vendor/advan/T812"
           remote="github"
           revision="lineage-21" />
  
  <!-- Dependencies -->
  <project name="LineageOS/android_device_mediatek_sepolicy_vndr"
           path="device/mediatek/sepolicy_vndr"
           remote="github"
           revision="lineage-21" />
  
  <project name="LineageOS/android_hardware_mediatek"
           path="hardware/mediatek"
           remote="github"
           revision="lineage-21" />
</manifest>
```

#### 3. Sync Source
```bash
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
```

#### 4. Extract Proprietary Blobs (Optional)
If you need to extract blobs from device:

```bash
cd device/advan/T812
./extract-files.py  # From connected device via ADB
# OR
./extract-files.py /path/to/stock/dump
./setup-makefiles.py

cd ../mt6789-common
./extract-files.py /path/to/stock/dump
./setup-makefiles.py
```

#### 5. Setup Build Environment
```bash
cd ~/lineage
source build/envsetup.sh
breakfast T812
```

#### 6. Build ROM
```bash
# Full build
mka bacon -j$(nproc --all)

# Or for faster builds (without official signing)
mka lineage -j$(nproc --all)
```

#### 7. Build Output
ROM will be located at:
```
out/target/product/T812/lineage-21.0-YYYYMMDD-UNOFFICIAL-T812.zip
```

### Build Time
- **First build**: 4-8 hours (depending on hardware)
- **Incremental builds**: 30-60 minutes
- **Clean builds**: 2-4 hours

---

## Audio Configuration

### Overview
The T812 tablet uses a custom audio configuration optimized for tablet use without an earpiece.

### Key Features
- **No Earpiece**: Removed from audio policy (comment: `jnier del 20230906`)
- **Dual Speakers**: Stereo speaker configuration
- **Smart PA**: Awinic amplifier with DSP
- **Headphone Jack**: 3.5mm audio support
- **4 Microphones**: For noise cancellation and voice calls

### Audio Policy Configuration
Location: `configs/audio/audio_policy_configuration.xml`

#### Attached Devices
```xml
<attachedDevices>
    <item>Speaker</item>
    <!-- Earpiece removed - tablet doesn't have one -->
    <item>Built-In Mic</item>
</attachedDevices>
```

#### Default Output Device
```xml
<defaultOutputDevice>Speaker</defaultOutputDevice>
```

#### Audio Routes
- **Speaker**: Primary audio output
- **Headphones**: 3.5mm jack output
- **USB Audio**: USB-C audio devices
- **Bluetooth**: A2DP audio streaming

### Smart PA Parameters
Located in vendor blobs:
```
vendor/etc/smartpa_param/AW_DSP.bin          # DSP firmware
vendor/etc/smartpa_param/AW_SINWAVE_DSP.bin  # Sine wave test
```

---

## Power Profile

### Overview
Device power profile is defined in the framework overlay for accurate battery estimation.

Location: `overlay/FrameworksResOverlayT812/res/xml/power_profile.xml`

### Battery Specifications
- **Capacity**: 5500 mAh (nominal)
- **Chemistry**: Li-Po (Lithium Polymer)
- **Charging**: USB Type-C, supports fast charging

### CPU Configuration

#### Cluster Configuration
```xml
<array name="cpu.clusters.cores">
    <value>6</value>  <!-- Cortex-A55 cluster (efficiency) -->
    <value>2</value>  <!-- Cortex-A76 cluster (performance) -->
</array>
```

#### CPU Frequencies - Cluster 0 (Cortex-A55)
```
500 MHz, 650 MHz, 700 MHz, 750 MHz, 800 MHz, 850 MHz,
900 MHz, 950 MHz, 1000 MHz, 1050 MHz, 1100 MHz, 1150 MHz,
1200 MHz, 1250 MHz, 1300 MHz, 1350 MHz, 1400 MHz, 1450 MHz,
1500 MHz, 1600 MHz, 1700 MHz, 1800 MHz, 1900 MHz, 2000 MHz
```

#### CPU Frequencies - Cluster 1 (Cortex-A76)
```
(Performance cores typically range from 1.8 GHz to 2.2 GHz max)
```

### Power Consumption Estimates
```xml
<item name="screen.on">0.1</item>           # Screen active power (mA)
<item name="screen.full">0.1</item>         # Screen at full brightness
<item name="bluetooth.active">0.1</item>    # Bluetooth active
<item name="wifi.on">0.1</item>             # Wi-Fi connected
<item name="wifi.scan">0.1</item>           # Wi-Fi scanning
<item name="gps.on">0.1</item>              # GPS active
<item name="camera.avg">0.1</item>          # Camera average power
```

**Note**: Default values of `0.1` indicate placeholder values. These should be calibrated with actual device measurements for accurate battery percentage estimation.

---

## Overlays & Customization

### FrameworksResOverlayT812

This Runtime Resource Overlay (RRO) customizes system behavior for the T812.

#### Overlay Priority
```xml
android:priority="350"
```
- Priority 350 ensures device-specific overrides take precedence
- Higher priority than common overlays (typically 300)

#### Customized Resources

##### Power Profile
- **Path**: `res/xml/power_profile.xml`
- **Purpose**: Battery capacity and power consumption data
- **Usage**: System uses this for battery percentage calculation

##### Additional Overrideable Resources
While currently only power profile is customized, the overlay can include:
- Display configurations (brightness curves, color calibration)
- Button mappings
- Navigation bar configuration
- Status bar layout
- Quick settings tiles

### Creating Additional Overlays

To add more customizations:

1. Add resource files to `overlay/FrameworksResOverlayT812/res/`
2. Follow Android resource structure (values/, xml/, drawable/, etc.)
3. Build system will automatically package overlay

Example structure:
```
overlay/FrameworksResOverlayT812/res/
├── values/
│   ├── config.xml       # System config overrides
│   ├── dimens.xml       # Dimension overrides
│   └── strings.xml      # String overrides
└── xml/
    └── power_profile.xml
```

---

## SELinux Policies

### Overview
T812 has minimal device-specific SELinux policies, primarily for TEE and DRM.

Location: `sepolicy/vendor/`

### Policy Files

#### file_contexts
Defines security contexts for device-specific files:
```
# TEE and security services
/vendor/bin/hw/android.hardware.security.keymint-service.trustkernel  u:object_r:hal_keymint_default_exec:s0
```

#### hal_drm_widevine.te
SELinux policy for Widevine DRM HAL:
```selinux
# Allow Widevine HAL to access TEE
allow hal_drm_widevine tee_device:chr_file rw_file_perms;
```

#### hal_keymint_default.te
SELinux policy for Keymint HAL (hardware keystore):
```selinux
# Allow Keymint to access TrustKernel TEE
allow hal_keymint_default tee_device:chr_file rw_file_perms;
```

### Base Policies
Most SELinux policies are inherited from:
1. **AOSP Base Policies**: Standard Android policies
2. **MediaTek Vendor Policies**: `device/mediatek/sepolicy_vndr`
3. **MT6789 Common Policies**: `device/advan/mt6789-common/sepolicy/vendor`

### Policy Development
To add new policies:
1. Identify denials: `adb shell dmesg | grep avc`
2. Create appropriate `.te` file in `sepolicy/vendor/`
3. Add rules to grant necessary permissions
4. Test in enforcing mode

---

## OTA Updates

### A/B Seamless Updates
The T812 fully supports A/B seamless system updates.

#### Partitions with A/B Slots
All critical partitions have A/B redundancy:
- **boot** (boot_a, boot_b)
- **vendor_boot** (vendor_boot_a, vendor_boot_b)
- **dtbo** (dtbo_a, dtbo_b)
- **vbmeta** (vbmeta_a, vbmeta_b, vbmeta_system_a/b, vbmeta_vendor_a/b)
- **Dynamic partitions** (system, vendor, product, system_ext, odm_dlkm, vendor_dlkm)
- **Firmware** (dpm, gz, lk, mcupm, md1img, pi_img, scp, spmfw, sspm, tee)

#### OTA Package Structure
LineageOS OTA packages include:
- Updated system/vendor/product images
- Updated firmware (if changed)
- OTA scripts for installation
- Post-install verification

#### Update Process
1. **Download**: OTA package downloaded to device
2. **Verification**: Package signature verified
3. **Installation**: Update applied to inactive slot
4. **Verification**: Inactive slot marked as bootable
5. **Reboot**: System boots from newly updated slot
6. **Verification**: Post-boot verification runs
7. **Finalization**: Update marked as successful

#### Rollback Protection
```makefile
BOARD_AVB_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 1
BOARD_AVB_VBMETA_VENDOR_ROLLBACK_INDEX := 1
```
- Prevents downgrade to older, potentially vulnerable versions
- Managed via Android Verified Boot (AVB)

#### OTA Assert
The update script checks device identity:
```
assert(getprop("ro.product.device") == "T812" ||
       getprop("ro.build.product") == "T812" ||
       getprop("ro.product.name") == "ADVAN_TAB_V8" ||
       getprop("ro.product.name") == "iPlay60_mini_Pro");
```

---

## Troubleshooting

### Common Build Issues

#### 1. Kernel Module Loading Failures
```
Error: Module xyz.ko not found
```
**Solution**: 
- Verify `T812-kernel` repository is cloned
- Check module exists in `device/advan/T812-kernel/modules/`
- Verify `modules.load` files are correct

#### 2. Missing Vendor Blobs
```
Error: vendor/advan/T812/proprietary/... not found
```
**Solution**:
```bash
cd device/advan/T812
./extract-files.py /path/to/stock/firmware
./setup-makefiles.py
```

#### 3. Audio Policy Errors
```
AudioPolicyManager: could not load audio policy configuration file
```
**Solution**: Verify `configs/audio/audio_policy_configuration.xml` exists and is valid XML.

#### 4. SELinux Denials
```
avc: denied { read write } for path="/dev/tee0" dev="tmpfs" ino=XXX
```
**Solution**: Add appropriate policy to `sepolicy/vendor/*.te` files.

### Runtime Issues

#### 1. No Audio Output
**Symptoms**: No sound from speakers or headphones

**Diagnosis**:
```bash
adb shell dumpsys audio
adb shell tinymix  # Check mixer settings
adb shell ps -A | grep audio
```

**Solutions**:
- Check audio HAL is running
- Verify Smart PA firmware loaded
- Check audio policy configuration

#### 2. Camera Not Working
**Symptoms**: Camera app crashes or shows black screen

**Diagnosis**:
```bash
adb shell dumpsys media.camera
adb shell ls -la /dev/video*
adb shell ps -A | grep camera
```

**Solutions**:
- Verify camerahalserver is running
- Check camera blobs are present
- Verify SELinux permissions for camera HAL

#### 3. Wi-Fi Not Connecting
**Symptoms**: Wi-Fi fails to connect or no networks visible

**Diagnosis**:
```bash
adb shell dumpsys wifi
adb shell dmesg | grep -i wifi
adb shell ls -la /vendor/firmware/WIFI*
```

**Solutions**:
- Verify Wi-Fi firmware is loaded
- Check wpa_supplicant is running
- Verify Wi-Fi module is loaded (check `lsmod`)

#### 4. Bootloop After Update
**Symptoms**: Device continuously reboots

**Diagnosis**:
```bash
adb wait-for-device shell dmesg > kernel.log
adb wait-for-device logcat > system.log
```

**Solutions**:
- Boot to recovery, wipe cache
- Flash stock firmware to recover
- Check for incompatible vendor blobs
- Verify bootloader compatibility

#### 5. Screen Flickering/Artifacts
**Symptoms**: Display shows artifacts or flickers

**Solutions**:
- Verify display density is set correctly (280 DPI)
- Check GPU drivers are loaded
- Verify display HAL is running

### Recovery Procedures

#### Factory Reset
```bash
# From recovery
adb shell recovery --wipe_data
```

#### Downgrade to Stock
1. Download stock firmware
2. Flash via SP Flash Tool (Windows)
3. Boot to stock recovery
4. Perform factory reset

#### Fastboot Mode
```bash
# Boot to bootloader
adb reboot bootloader

# Check device
fastboot devices

# Flash images
fastboot flash boot boot.img
fastboot flash vendor_boot vendor_boot.img
```

---

## Advanced Customization

### Kernel Customization
If you want to build kernel from source instead of using prebuilt:

1. Obtain kernel source (if available)
2. Remove `TARGET_NO_KERNEL_OVERRIDE := true` from BoardConfig.mk
3. Set `TARGET_KERNEL_SOURCE := path/to/kernel/source`
4. Configure kernel: `TARGET_KERNEL_CONFIG := mt6789_defconfig`
5. Build normally - kernel will be compiled

### Adding Custom Apps
To include custom apps in ROM:

1. Add APK to device tree: `device/advan/T812/prebuilt/apps/`
2. In device.mk, add:
```makefile
PRODUCT_PACKAGES += \
    YourCustomApp

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/apps/YourApp.apk:$(TARGET_COPY_OUT_SYSTEM)/priv-app/YourApp/YourApp.apk
```

### Performance Tuning
Adjust CPU governor and scheduler in:
- `device/advan/mt6789-common/configs/perf/`
- Modify thermal profiles
- Adjust CPU frequency scaling

---

## Testing Checklist

Before releasing a build, verify:

- [ ] Device boots successfully
- [ ] Display works (correct resolution and DPI)
- [ ] Touch input responsive
- [ ] Both cameras functional (front and rear)
- [ ] Audio output (speakers, headphones)
- [ ] Audio input (microphones)
- [ ] Wi-Fi connects and data transfer works
- [ ] Bluetooth pairing and audio
- [ ] Cellular data (if SIM inserted)
- [ ] Phone calls (if SIM inserted)
- [ ] GPS location services
- [ ] All sensors working (accelerometer, gyro, compass, light, proximity)
- [ ] MicroSD card detection and read/write
- [ ] USB OTG devices detected
- [ ] Battery charging
- [ ] Battery percentage accurate
- [ ] SELinux enforcing mode
- [ ] SafetyNet/Play Integrity passes (if applicable)
- [ ] OTA updates work

---

## Contributing

### Reporting Issues
When reporting issues, include:
1. LineageOS build date and version
2. Exact steps to reproduce
3. Relevant logs (`adb logcat`, `dmesg`)
4. SELinux denials (if applicable)

### Submitting Patches
1. Fork the repository
2. Create feature branch
3. Make changes following coding standards
4. Test thoroughly
5. Submit pull request with detailed description

### Code Style
- Follow AOSP coding conventions
- Use 4-space indentation (no tabs)
- Add SPDX license headers
- Comment complex logic

---

## License

```
Copyright (C) 2025 The LineageOS Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

**SPDX-License-Identifier**: Apache-2.0

---

## References

- [LineageOS Wiki](https://wiki.lineageos.org/)
- [Android Source Documentation](https://source.android.com/)
- [MediaTek Developer Portal](https://www.mediatek.com/)
- [Common Device Tree](../mt6789-common/DOCUMENTATION.md)
- [Advan Tab V8 Product Page](https://www.advan.id/)

---

## Appendix

### Related Files
- **Common Device Tree**: `device/advan/mt6789-common/`
- **Vendor Blobs Common**: `vendor/advan/mt6789-common/`
- **Vendor Blobs T812**: `vendor/advan/T812/`
- **Prebuilt Kernel**: `device/advan/T812-kernel/`

### Build Variants
- **userdebug**: Debug-enabled build (recommended for development)
- **user**: Production build (enforcing security)
- **eng**: Engineering build (full debug, root access)

### Useful Commands
```bash
# Check device properties
adb shell getprop | grep product

# Check running services
adb shell service list

# Check SELinux status
adb shell getenforce

# Check kernel version
adb shell uname -a

# Check loaded modules
adb shell lsmod

# Monitor logs
adb logcat -v threadtime

# Check battery info
adb shell dumpsys battery
```

---

**Document Version**: 1.0  
**Last Updated**: 2024-12-04  
**Maintainers**: Device tree maintainers  
**Device**: Advan Tab V8 (T812)
