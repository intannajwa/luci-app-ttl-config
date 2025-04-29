local m, s, o
m = Map("ttl", translate("Antitethering Config"))

s = m:section(TypedSection, "ttl", translate("TTL antitether"))
s.anonymous = true
s.addremove = true

o = s:option(Value, "iface", translate("Set interface"))

o = s:option(Flag, "advanced", translate("Advanced Option"))
o.default = '0'
o.rmempty = false

o = s:option(ListValue, "inet", translate("Inet Family"))
o:value("ipv4", "IPv4")
o:value("ipv6", "IPv6")
o:value("ipv4v6", translate("Both"))
o.rmempty = true
o.editable = true
o:depends("advanced", "1")

o = s:option(Value, "ttl", translate("TTL Value"))
o:value("64", "64")
o:value("128", "128")
o.default = "64"
o.rmempty = true
o.editable = true
o:depends("advanced", "1")

return m
