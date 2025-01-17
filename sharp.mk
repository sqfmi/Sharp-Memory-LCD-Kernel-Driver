SHARP_VERSION = 1.0
SHARP_SITE = $(BR2_EXTERNAL_BEEPY_DRIVERS_PATH)/package/sharp
SHARP_SITE_METHOD = local

SHARP_INSTALL_IMAGES = YES
SHARP_MODULE_SUBDIRS = .

define SHARP_BUILD_CMDS
	for dts in $(@D)/*.dts; do \
		$(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $${dts%.dts}.dtbo $${dts}; \
	done
endef

define SHARP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/init/S01sharp $(TARGET_DIR)/etc/init.d/;
endef

define SHARP_INSTALL_IMAGES_CMDS
	for dtbo in $(@D)/*.dtbo; do \
		$(INSTALL) -D -m 0644 $${dtbo} $(BINARIES_DIR)/rpi-firmware/overlays; \
	done
endef

$(eval $(kernel-module))
$(eval $(generic-package))
