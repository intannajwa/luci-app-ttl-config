local fs = require("nixio.fs")
local uci = require("uci").cursor()

module("luci.model.cbi.ttlconfig", package.seeall)

function set_ttl_value(chain, ttl_value)
    local nft_config = "/etc/nftables.d/10-custom-filter-chains.nft"
    local command = "sed -i 's/^\(.*chain " .. chain .. ".*ttl set \)[0-9]\+/\1" .. ttl_value .. "/' " .. nft_config

    os.execute(command)  -- Run the command to modify the TTL value in the config

    -- Apply the new nftables configuration
    os.execute("nft -f " .. nft_config)
end

-- Function to retrieve the current TTL value for a chain
function get_current_ttl(chain)
    local nft_config = "/etc/nftables.d/10-custom-filter-chains.nft"
    local command = "grep -oP 'chain " .. chain .. ".*ttl set \K[0-9]+' " .. nft_config
    local ttl_value = io.popen(command):read("*a")
    return ttl_value:match("%d+")
end
