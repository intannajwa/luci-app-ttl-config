module("luci.controller.admin.network.ttlconfig", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ttl") then
		return
	end

	entry({"admin", "network", "ttl-config"}, cbi("ttl-config/ttlconfig"), _("TTL Configurator"), 100).dependent = true
end
