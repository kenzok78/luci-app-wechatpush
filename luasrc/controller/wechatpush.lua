-- Copyright (C) 2025 kenzok78
-- SPDX-License-Identifier: Apache-2.0

module("luci.controller.wechatpush", package.seeall)

local fs = require "nixio.fs"

function index()
	if not fs.access("/etc/config/wechatpush") then
		return
	end

	-- luci 23.05+ 已通过 menu.d JSON 注册菜单，无需重复注册
	if fs.access("/usr/share/luci/menu.d/luci-app-wechatpush.json") then
		return
	end

	local page
	page = entry({"admin", "services", "wechatpush"}, cbi("wechatpush"), _("WeChat push"), 30)
	page.dependent = true
	page.acl_depends = { "luci-app-wechatpush" }
end
