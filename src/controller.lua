module("luci.controller.ttlconfig", package.seeall)

local ttlconfig = require("luci.model.cbi.ttlconfig")

function index()
    entry({"admin", "modem", "ttl-config"}, cbi("ttl-config/ttlconfig"), _("TTL Config"), 60)

    -- Handle form submission
    if luci.http.formvalue("submit") then
        local ttl_value = luci.http.formvalue("ttl_value")
        local chain = luci.http.formvalue("chain")
        if ttl_value and chain then
            ttlconfig.set_ttl_value(chain, ttl_value)  -- Apply the new TTL value
            luci.sys.call("uci commit")  -- Commit changes if any
            luci.http.redirect(luci.dispatcher.build_url("admin/network/ttl-config"))
        end
    end
end
