/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <aidl/android/hardware/power/BnPower.h>
#include <android-base/file.h>
#include <android-base/logging.h>
#include <sys/ioctl.h>

namespace aidl {
namespace android {
namespace hardware {
namespace power {
namespace impl {
namespace mediatek {

using ::aidl::android::hardware::power::Mode;

bool isDeviceSpecificModeSupported(Mode type, bool* _aidl_return) {
    switch (type) {
        case Mode::DOUBLE_TAP_TO_WAKE:
            *_aidl_return = true;
            return true;
        default:
            return false;
    }
}

bool setDeviceSpecificMode(Mode type, bool enabled) {
    switch (type) {
        case Mode::DOUBLE_TAP_TO_WAKE: {
            ::android::base::WriteStringToFile(enabled ? "1" : "0", "/proc/android_touch/GESTURE", true);
            ::android::base::WriteStringToFile(enabled ? "1" : "0", "/proc/android_touch/SMWP", true);
            return true;
        }
        default:
            return false;
    }
}

}  // namespace mediatek
}  // namespace impl
}  // namespace power
}  // namespace hardware
}  // namespace android
}  // namespace aidl
