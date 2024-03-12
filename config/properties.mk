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
    vendor/kanged/properties

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# properties
PRODUCT_PRODUCT_PROPERTIES += \
    persist.wm.extensions.enabled=true

PRODUCT_PRODUCT_PROPERTIES += \
    persist.rcs.supported=1 \
    ro.opa.eligible_device=true \
    ro.com.google.ime.theme_id=5 \
    ro.com.google.ime.bs_theme=true \
    ro.com.google.ime.system_lm_dir=/product/usr/share/ime/google/d3_lms \
    ro.product.locale=en-US \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.product.needs_model_edit=false \
    ro.support_one_handed_mode=true \
    persist.sys.storage_picker_enabled=true \
    debug.photos.p_editr.eraser=1 \
    debug.photos.force_pixel_eol=1 \
    debug.photos.eraser_camo=1 \
    debug.photos.eraser_suggestion=1 \
    ro.support_hide_display_cutout=true

# misc properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.input.video_enabled=false \
    arm64.memtag.process.system_server=off

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.systemuicompilerfilter=speed \
    persist.sys.strictmode.disable=true

# Blurs
ifeq ($(TARGET_ENABLE_BLUR), true)
PRODUCT_PRODUCT_PROPERTIES += \
    ro.sf.blurs_are_expensive=1 \
    ro.surface_flinger.supports_background_blur=1
endif

# Freeform
TARGET_DEVICE_IS_TABLET ?= false
PRODUCT_PRODUCT_PROPERTIES += \
    persist.wm.debug.desktop_mode=false
ifeq ($(TARGET_DEVICE_IS_TABLET), true)
PRODUCT_PRODUCT_PROPERTIES += \
    persist.wm.debug.desktop_mode.default_width=840 \
    persist.wm.debug.desktop_mode.default_height=630
else
PRODUCT_PRODUCT_PROPERTIES += \
    persist.wm.debug.desktop_mode.default_width=230 \
    persist.wm.debug.desktop_mode.default_height=360
endif

# Art
PRODUCT_PRODUCT_PROPERTIES += \
    pm.dexopt.post-boot=extract \
    pm.dexopt.boot-after-mainline-update=verify \
    pm.dexopt.install=speed-profile \
    pm.dexopt.install-fast=skip \
    pm.dexopt.install-bulk=speed-profile \
    pm.dexopt.install-bulk-secondary=verify \
    pm.dexopt.install-bulk-downgraded=verify \
    pm.dexopt.install-bulk-secondary-downgraded=extract \
    pm.dexopt.bg-dexopt=speed-profile \
    pm.dexopt.ab-ota=speed-profile \
    pm.dexopt.inactive=verify \
    pm.dexopt.cmdline=verify \
    pm.dexopt.shared=speed \
    pm.dexopt.first-boot=verify \
    pm.dexopt.boot-after-ota=verify \
    dalvik.vm.minidebuginfo=false \
    dalvik.vm.dex2oat-minidebuginfo=false

# Permissions
PRODUCT_PRODUCT_PROPERTIES += \
    ro.control_privapp_permissions=log

PRODUCT_BUILD_PROP_OVERRIDES += \
    PIHOOKS_BUILD_DESC="griffin-user 6.0.1 MCC24.246-37 42 release-keys"

# PropHooks
PRODUCT_SYSTEM_PROPERTIES += \
    persist.sys.pihooks.brand?=motorola \
    persist.sys.pihooks.manufacturer?=motorola \
    persist.sys.pihooks.product_device?=griffin \
    persist.sys.pihooks.product_name?=griffin \
    persist.sys.pihooks.product_model?=XT1650-05 \
    persist.sys.pihooks.build_fingerprint?=motorola/griffin_retcn/griffin:6.0.1/MCC24.246-37/42:user/release-keys \
    persist.sys.pihooks.first_api_level?=32 \
    persist.sys.pihooks.security_patch?=2016-07-01 \
    persist.sys.pihooks.build_id?=MCC24.246-37 \
    persist.sys.pihooks.build_type?=user \
    persist.sys.pihooks.build_tags?=release-keys \
    persist.sys.pihooks.verifiedbootstate?=green \
    persist.sys.pihooks.flash.locked?=1 \
    persist.sys.pihooks.vbmeta.device_state?=locked

