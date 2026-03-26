-- Copyright (C) 2025 kenzok78
-- SPDX-License-Identifier: Apache-2.0

local sys = require "luci.sys"

m = Map("wechatpush", translate("WeChat push"),
	translate("A tool that can push device messages from OpenWrt to a mobile phone via WeChat or Telegram."))

-- 服务状态
local running = (sys.call("pidof wechatpush >/dev/null 2>&1") == 0)
local status_text = running
	and '<span style="color:green"><strong>' .. translate("RUNNING") .. "</strong></span>"
	or  '<span style="color:red"><strong>' .. translate("NOT RUNNING") .. "</strong></span>"

s = m:section(TypedSection, "_status", translate("Service Status"))
s.anonymous = true
s.addremove = false

o = s:option(DummyValue, "_status", translate("Status"))
o.rawhtml = true
o.default = status_text

-- 基本设置
s = m:section(NamedSection, "config", "wechatpush", translate("Basic Settings"))
s.anonymous = false
s.addremove = false

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty = false

o = s:option(ListValue, "jsonpath", translate("Push Mode"))
o:value("", translate("Close"))
o:value("/usr/share/wechatpush/api/serverchan.json", translate("WeChat serverchan"))
o:value("/usr/share/wechatpush/api/serverchan3.json", translate("Serverchan3 APP"))
o:value("/usr/share/wechatpush/api/qywx_mpnews.json", translate("WeChat Work Image Message"))
o:value("/usr/share/wechatpush/api/qywx_markdown.json", translate("WeChat Work Markdown Version"))
o:value("/usr/share/wechatpush/api/wxpusher.json", translate("wxpusher"))
o:value("/usr/share/wechatpush/api/pushplus.json", translate("pushplus"))
o:value("/usr/share/wechatpush/api/telegram.json", translate("Telegram"))
o:value("/usr/share/wechatpush/api/msmtp.json", translate("msmtp"))
o:value("/usr/share/wechatpush/api/diy.json", translate("Custom Push"))

o = s:option(Value, "sckey", translate("sendkey"))
o.rmempty = true
o:depends("jsonpath", "/usr/share/wechatpush/api/serverchan.json")

o = s:option(Value, "sc3key", translate("Serverchan3 sendkey"))
o.rmempty = true
o:depends("jsonpath", "/usr/share/wechatpush/api/serverchan3.json")

o = s:option(Value, "tg_token", translate("Bot Token"))
o.rmempty = true
o:depends("jsonpath", "/usr/share/wechatpush/api/telegram.json")

o = s:option(Value, "tg_chat_id", translate("Chat ID"))
o.rmempty = true
o:depends("jsonpath", "/usr/share/wechatpush/api/telegram.json")

o = s:option(Value, "tg_api_server", translate("API Server URL"))
o.placeholder = "https://api.telegram.org"
o.rmempty = true
o:depends("jsonpath", "/usr/share/wechatpush/api/telegram.json")

o = s:option(Value, "pushplus_token", translate("pushplus_token"))
o.rmempty = true
o:depends("jsonpath", "/usr/share/wechatpush/api/pushplus.json")

o = s:option(Value, "device_name", translate("Device Name"))
o.rmempty = true

o = s:option(Value, "sleeptime", translate("Check Interval (s)"))
o.placeholder = "60"
o.datatype = "and(uinteger,min(10))"
o.rmempty = false

return m
