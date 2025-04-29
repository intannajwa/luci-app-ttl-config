include $(TOPDIR)/rules.mk

LUCI_TITLE:=TTL Configurator
LUCI_DEPENDS:=+luci-base +nftables
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-ttl-config
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=$(LUCI_TITLE)
  DEPENDS:=$(LUCI_DEPENDS)
  PKGARCH:=$(LUCI_PKGARCH)
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/www/luci-static/ttl-config
	$(INSTALL_DATA) ./src/view/ttlconfig.htm $(1)/www/luci-static/ttl-config/ttlconfig.htm

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/admin/network
	$(INSTALL_DATA) ./src/controller.lua $(1)/usr/lib/lua/luci/controller/admin/network/ttlconfig.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/ttl-config
	$(INSTALL_DATA) ./src/model/ttlconfig.lua $(1)/usr/lib/lua/luci/model/cbi/ttl-config/ttlconfig.lua
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
