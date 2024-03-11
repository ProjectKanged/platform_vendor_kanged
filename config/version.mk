#
# Copyright (C) 2024 risingOS
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
    vendor/kanged/version

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0

KANGED_FLAVOR := UDC
KANGED_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)
KANGED_CODENAME := MATAKA
KANGED_RELEASE_TYPE := RELEASE
KANGED_CODE := $(KANGED_VERSION)

KANGED_BUILD_DATE := $(shell date -u +%Y%m%d)

MAINTAINER_LIST = $(shell cat vendor/kangedOTA/official.maintainers)
DEVICE_LIST = $(shell cat vendor/kangedOTA/official.devices)

ifeq ($(filter $(KANGED_BUILD), $(DEVICE_LIST)), $(KANGED_BUILD))
   ifeq ($(filter $(KANGED_MAINTAINER), $(MAINTAINER_LIST)), $(KANGED_MAINTAINER))
      KANGED_BUILDTYPE := OFFICIAL
  else 
     # the builder is overriding official flag on purpose
     ifeq ($(KANGED_BUILDTYPE), OFFICIAL)
       $(error **********************************************************)
       $(error *     A violation has been detected, aborting build      *)
       $(error **********************************************************)
       KANGED_BUILDTYPE := UNOFFICIAL
     else 
       $(warning **********************************************************************)
       $(warning *   There is already an official maintainer for $(KANGED_BUILD)    *)
       $(warning *              Setting build type to UNOFFICIAL                      *)
       $(warning *    Please contact current official maintainer before distributing  *)
       $(warning *              the current build to the community.                   *)
       $(warning **********************************************************************)
       KANGED_BUILDTYPE := UNOFFICIAL
     endif
  endif
else
   ifeq ($(KANGED_BUILDTYPE), OFFICIAL)
     $(error **********************************************************)
     $(error *     A violation has been detected, aborting build      *)
     $(error **********************************************************)
   endif
  KANGED_BUILDTYPE := COMMUNITY
endif

ifeq ($(WITH_GMS), true)
	ifeq ($(TARGET_CORE_GMS), true)
    	KANGED_PACKAGE_TYPE ?= CORE
	else 
    	KANGED_PACKAGE_TYPE ?= GAPPS
	endif
else
    KANGED_PACKAGE_TYPE ?= VANILLA
endif

# Build version
KANGED_BUILD_VERSION := $(KANGED_VERSION)-$(KANGED_RELEASE_TYPE)-$(KANGED_BUILD_DATE)-$(KANGED_PACKAGE_TYPE)-$(KANGED_BUILDTYPE)-$(KANGED_BUILD)

# Display version
KANGED_DISPLAY_VERSION := $(KANGED_VERSION)-$(KANGED_RELEASE_TYPE)-$(KANGED_PACKAGE_TYPE)-$(KANGED_BUILDTYPE)-$(KANGED_BUILD)

# Project Kanged properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.kanged.maintainer=$(KANGED_MAINTAINER) \
    ro.kanged.code=$(KANGED_CODENAME) \
    ro.kanged.packagetype=$(KANGED_PACKAGE_TYPE) \
    ro.kanged.releasetype=$(KANGED_BUILDTYPE) \
    ro.kanged.version?=$(KANGED_VERSION) \
    ro.kanged.build.version=$(KANGED_BUILD_VERSION) \
    ro.kanged.display.version?=$(KANGED_DISPLAY_VERSION) \
    ro.kanged.platform_release_codename=$(KANGED_FLAVOR) \
    ro.kanged.device=$(KANGED_BUILD) \
    ro.kanged.chipset?=$(KANGED_CHIPSET) \
    ro.kanged.storage?=$(KANGED_STORAGE) \
    ro.kanged.ram?=$(KANGED_RAM) \
    ro.kanged.battery?=$(KANGED_BATTERY) \
    ro.kanged.display_resolution?=$(KANGED_DISPLAY)
