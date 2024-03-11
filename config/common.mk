#
# Copyright (C) 2024 Project Kanged
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

PRODUCT_SOONG_NAMESPACES += \
    vendor/kanged/common

include vendor/kanged/config/properties.mk
include vendor/kanged/config/packages.mk
include vendor/kanged/config/version.mk
include vendor/kanged/audio/config.mk
include vendor/kanged/overlays/config.mk
-include vendor/pixeloverlays/config.mk

# GMS
WITH_GMS?=true
ifeq ($(WITH_GMS), true)
include vendor/partner_gms/products/gms.mk
endif

# Dexopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStep \
    NexusLauncherRelease

# Freeform
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.freeform_window_management.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Extracted APN's from Cheetah
PRODUCT_COPY_FILES += \
    vendor/kanged/prebuilts/apn/apns-conf.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/apns-conf.xml

# Bootanimation
PRODUCT_COPY_FILES += \
    vendor/kanged/bootanimation/bootanimation.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation.zip \
    vendor/kanged/bootanimation/bootanimation-dark.zip:$(TARGET_COPY_OUT_PRODUCT)/media/bootanimation-dark.zip
