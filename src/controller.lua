module("luci.controller.ttlconfig", package.seeall)

function index()
    -- Define the LuCI page
    entry({"admin", "network", "ttl-config"}, template("ttlconfig"), _("TTL Configurator"), 60)
end

function apply_ttl_config(value, iface)
    -- Apply the TTL configuration using nftables
    local ttl = tonumber(value)
    if ttl then
        -- Apply the TTL setting via nftables for the selected interface
        local cmd = string.format("nft add rule inet filter prerouting ip ttl set %d iifname '%s'", ttl, iface)
        os.execute(cmd)
        local cmd2 = string.format("nft add rule inet filter postrouting ip ttl set %d oifname '%s'", ttl, iface)
        os.execute(cmd2)

        -- Return success
        return true
    else
        -- Return failure if TTL is invalid
        return false
    end
end

-- Handle the HTTP POST request from the form submission
function handle_form()
    local value = luci.http.formvalue("ttl_value")
    local iface = luci.http.formvalue("iface")

    if apply_ttl_config(value, iface) then
        luci.template.render("ttlconfig", {success = "TTL configuration applied successfully."})
    else
        luci.template.render("ttlconfig", {error = "Failed to apply TTL configuration."})
    end
end
