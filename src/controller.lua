module("luci.controller.ttlconfig", package.seeall)

function index()
    entry({"admin", "network", "ttl-config"}, cbi("ttl-config/ttlconfig"), _("TTL Config"), 60)
end
