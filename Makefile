MODULE_DIR := $(CURDIR)
ZIP_NAME   ?= PowerOffAlarm_Fix-CRDroid7.1.zip
ZIP_PATH   := ../$(ZIP_NAME)

.PHONY: all package verify clean clean-macos install

all: package

package: clean-macos verify
	@rm -f "$(ZIP_PATH)"
	@echo "Packaging $(ZIP_NAME) ..."
	@cd "$(MODULE_DIR)" && zip -r "$(ZIP_PATH)" . \
		-x '*.DS_Store' \
		-x '.DS_Store' \
		-x '__MACOSX/*' \
		-x '._*' \
		-x 'Makefile' \
		-x 'makefile' \
		-x '.git/*' \
		-x '*.zip'
	@echo "Created: $(ZIP_PATH)"
	@unzip -l "$(ZIP_PATH)" | head -20

verify:
	@test -f module.prop || (echo "ERROR: module.prop missing"; exit 1)
	@test -f sepolicy.rule || (echo "ERROR: sepolicy.rule missing"; exit 1)
	@if [ -f post-fs-data.sh ]; then chmod +x post-fs-data.sh; fi
	@echo "Module structure OK"

clean-macos:
	@find . -name '.DS_Store' -delete
	@find . -name '._*' -delete
	@find . -name '__MACOSX' -type d -prune -exec rm -rf {} +

clean:
	@rm -f "$(ZIP_PATH)"
	@echo "Removed: $(ZIP_PATH)"

install: package
	@adb push "$(ZIP_PATH)" /sdcard/Download/
	@echo "Pushed to /sdcard/Download/$(ZIP_NAME)"