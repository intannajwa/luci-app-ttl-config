module("luci.model.cbi.ttlconfig", package.seeall)

function ttl_config()
    local map = Map("ttl", "TTL Configuration")

    local section = map:section(TypedSection, "ttl", "Configure TTL Values")
    section.anonymous = true
    section.addremove = true

    section:option(Value, "ttl_value", "TTL Value", "Set TTL value (range: 1-255)"):value("64")
    section:option(Value, "iface", "Interface", "Select the interface to apply TTL"):value("eth0")
    
    return map
end
