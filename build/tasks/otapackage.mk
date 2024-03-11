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

# -----------------------------------------------------------------
# Project Kanged OTA package

KANGED_TARGET_PACKAGE := $(PRODUCT_OUT)/kanged-$(KANGED_BUILD_VERSION)-ota.zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: otapackage
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(KANGED_TARGET_PACKAGE)
	$(hide) $(SHA256) $(KANGED_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(KANGED_TARGET_PACKAGE).sha256sum
	@echo ""
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "  ██████╗ ██████╗  ██████╗      ██╗███████╗ ██████╗████████╗   " >&2
	@echo "  ██╔══██╗██╔══██╗██╔═══██╗     ██║██╔════╝██╔════╝╚══██╔══╝   " >&2
	@echo "  ██████╔╝██████╔╝██║   ██║     ██║█████╗  ██║        ██║      " >&2
	@echo "  ██╔═══╝ ██╔══██╗██║   ██║██   ██║██╔══╝  ██║        ██║      " >&2
	@echo "  ██║     ██║  ██║╚██████╔╝╚█████╔╝███████╗╚██████╗   ██║      " >&2
	@echo "  ╚═╝     ╚═╝  ╚═╝ ╚═════╝  ╚════╝ ╚══════╝ ╚═════╝   ╚═╝      " >&2
	@echo "                                                               " >&2
	@echo "     ██╗  ██╗ █████╗ ███╗   ██╗ ██████╗ ███████╗██████╗        " >&2
	@echo "     ██║ ██╔╝██╔══██╗████╗  ██║██╔════╝ ██╔════╝██╔══██╗       " >&2
	@echo "     █████╔╝ ███████║██╔██╗ ██║██║  ███╗█████╗  ██║  ██║       " >&2
	@echo "     ██╔═██╗ ██╔══██║██║╚██╗██║██║   ██║██╔══╝  ██║  ██║       " >&2
	@echo "     ██║  ██╗██║  ██║██║ ╚████║╚██████╔╝███████╗██████╔╝       " >&2
	@echo "     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚═════╝        " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo "                                                               " >&2
	@echo ""
	@echo "Creating json OTA..." >&2
	$(hide) ./vendor/kanged/build/tools/createjson.sh $(TARGET_DEVICE) $(PRODUCT_OUT) kanged-$(KANGED_BUILD_VERSION)-ota.zip $(KANGED_VERSION) $(KANGED_CODENAME) $(KANGED_PACKAGE_TYPE) $(KANGED_RELEASE_TYPE)
	$(hide) cp -f $(PRODUCT_OUT)/$(TARGET_DEVICE).json vendor/kangedOTA/$(TARGET_DEVICE).json
	@echo ":·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·:" >&2
	@echo " Size            : $(shell du -hs $(KANGED_TARGET_PACKAGE) | awk '{print $$1}')"
	@echo " Size(in bytes)  : $(shell wc -c $(KANGED_TARGET_PACKAGE) | awk '{print $$1}')"
	@echo " Package Complete: $(KANGED_TARGET_PACKAGE)" >&2
	@echo ":·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·::·.·.·:" >&2
	@echo ""
