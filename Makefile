SHELL := /bin/bash

MODULE_DIR := module
REC_DIR    := rec

# Get module version
MODULE_VERSION := $(shell sed -n 's/^version=//p' $(MODULE_DIR)/module.prop 2>/dev/null | head -n1 | tr -d '[:space:]' | sed 's/^[vV]//')
ifeq ($(strip $(MODULE_VERSION)),)
MODULE_VERSION := unknown
endif

MODULE_ZIP := PowerOffAlarm_Fix-CRDroid7.1-v$(MODULE_VERSION).zip
REC_ZIP    := PowerOffAlarm_REC_Fix-CRDroid7.1.zip

MACOS_EXCLUDE := -x '*.DS_Store' -x '__MACOSX/*' -x '._*'

# Check all the files
MODULE_REQUIRED := module.prop
REC_REQUIRED    := META-INF/com/google/android/update-binary \
                   META-INF/com/google/android/updater-script \
                   power_off_alarm

.PHONY: all module rec verify-module verify-rec clean clean-macos help version

all: module rec

help:
	@echo "Targets:"
	@echo "  make              build both ZIPs"
	@echo "  make module       build $(MODULE_ZIP)"
	@echo "  make rec          build $(REC_ZIP)"
	@echo "  make version      show detected module version"
	@echo "  make clean        remove built ZIPs"
	@echo "  make clean-macos  remove .DS_Store / ._* / __MACOSX in sources"

version:
	@echo "$(MODULE_VERSION)"

module: verify-module clean-macos
	@echo "==> Building $(MODULE_ZIP) (version $(MODULE_VERSION))"
	@chmod 755 $(MODULE_DIR)/post-fs-data.sh 2>/dev/null || true
	@chmod 755 $(MODULE_DIR)/service.sh 2>/dev/null || true
	@chmod 755 $(MODULE_DIR)/customize.sh 2>/dev/null || true
	@rm -f $(MODULE_ZIP)
	@cd $(MODULE_DIR) && zip -r ../$(MODULE_ZIP) . $(MACOS_EXCLUDE) >/dev/null
	@echo "==> Done: $(MODULE_ZIP)"
	@unzip -l $(MODULE_ZIP) | head -15

rec: verify-rec clean-macos
	@echo "==> Building $(REC_ZIP)"
	@chmod 755 $(REC_DIR)/META-INF/com/google/android/update-binary
	@chmod 644 $(REC_DIR)/META-INF/com/google/android/updater-script
	@chmod 755 $(REC_DIR)/power_off_alarm
	@rm -f $(REC_ZIP)
	@cd $(REC_DIR) && zip -r ../$(REC_ZIP) . $(MACOS_EXCLUDE) >/dev/null
	@echo "==> Done: $(REC_ZIP)"
	@unzip -l $(REC_ZIP) | head -15

verify-module:
	@for f in $(MODULE_REQUIRED); do \
		test -f $(MODULE_DIR)/$$f || { echo "ERROR: $(MODULE_DIR)/$$f missing"; exit 1; }; \
	done
	@echo "==> module/ structure OK"

verify-rec:
	@for f in $(REC_REQUIRED); do \
		test -f $(REC_DIR)/$$f || { echo "ERROR: $(REC_DIR)/$$f missing"; exit 1; }; \
	done
	@echo "==> rec/ structure OK"

clean:
	@rm -f PowerOffAlarm_Fix-CRDroid7.1-v*.zip $(REC_ZIP)
	@echo "==> Cleaned"

clean-macos:
	@find $(MODULE_DIR) $(REC_DIR) -name '.DS_Store' -delete 2>/dev/null || true
	@find $(MODULE_DIR) $(REC_DIR) -name '._*' -delete 2>/dev/null || true
	@find $(MODULE_DIR) $(REC_DIR) -name '__MACOSX' -type d -prune -exec rm -rf {} + 2>/dev/null || true