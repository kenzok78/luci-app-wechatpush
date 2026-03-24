# luci-app-wechatpush

[![license](https://img.shields.io/badge/license-GPL--3.0-brightgreen.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/kenzok78/luci-app-wechatpush/pulls)
[![Lastest Release](https://img.shields.io/github/release/tty228/luci-app-wechatpush.svg?style=flat)](https://github.com/kenzok78/luci-app-wechatpush/releases)

LuCI 管理界面 for 微信、Telegram、邮件通知插件。用于 OpenWRT 路由器上的多通道推送服务。

<small>

## 功能特性

- 路由 IP、IPv6 变动推送
- 设备上线、离线推送
- 设备在线列表及流量使用情况
- CPU 负载、温度监视、PVE 宿主机温度监控
- 路由运行状态定时推送
- 路由 Web、SSH 登录提示，自动拉黑、端口敲门
- 无人值守任务

## 通知服务支持

| 推送应用 | 方式 | 接口说明 |
| :-------- | :----- | :----- |
| 微信 | Server酱 | https://sct.ftqq.com/ |
| 微信 | 推送加 | http://www.pushplus.plus/ |
| 微信 | WxPusher | https://wxpusher.zjiecode.com/docs |
| 企业微信 | 应用推送 | https://work.weixin.qq.com/api/doc/90000/90135/90248 |
| Telegram | bot | https://t.me/BotFather |
| Mail | msmtp | https://marlam.de/msmtp/ |

## 系统要求

- OpenWrt 19.07 或更高版本
- LuCI 19.07+ Web 界面

**注意:** v3.x 版本不再支持 LuCI 18.06，如需 18.06 支持请使用 v2.06.2 版本。

代码分析表明使用了现代 LuCI JavaScript API (`htdocs/luci-static/resources/view/`)，这是 LuCI 19.07+ 引入的新结构。

## 依赖项

- `iputils-arping`
- `curl`
- `jq`
- `bash`
- `luci-lua-runtime`

### 可选依赖

- `wrtbwmon` - 流量统计功能
- `lsblk` - 硬盘容量信息
- `smartmontools` - 硬盘温度、通电时间
- `openssh-client` / `openssh-keygen` - PVE 宿主机信息

## 安装

### 从源码编译

```bash
git clone https://github.com/kenzok78/luci-app-wechatpush.git
mv luci-app-wechatpush /path/to/openwrt/package/feeds/luci/
make package/luci-app-wechatpush/compile V=99
```

### 在线安装

```bash
opkg update
opkg install luci-app-wechatpush
```

## 配置

1. 登录 LuCI 管理界面
2. 进入 **服务 → 微信推送**
3. 配置通知渠道（Server酱/Telegram/邮件等）
4. 保存并应用

## 代码优化

### 修复的问题

- uci-defaults 脚本：`function` 关键字在 `/bin/sh` 下不兼容，已移除
- uci-defaults 脚本：修复变量检查逻辑 `[ -n "$1" ]` 替代 `[[ "$*" != "" ]]`
- uci-defaults 脚本：添加 `2>/dev/null` 避免无配置时报错

## 目录结构

```
luci-app-wechatpush/
├── htdocs/
│   └── luci-static/
│       └── resources/
│           └── view/
│               └── wechatpush/
│                   ├── status.js
│                   ├── config.js
│                   ├── log.js
│                   ├── advanced.js
│                   └── client.js
├── root/
│   ├── etc/
│   │   ├── init.d/
│   │   │   └── wechatpush
│   │   ├── config/
│   │   │   └── wechatpush
│   │   └── uci-defaults/
│   │       └── luci-wechatpush
│   ├── share/
│   │   ├── rpcd/
│   │   │   └── acl.d/
│   │   │       └── luci-app-wechatpush.json
│   │   ├── luci/
│   │   │   └── menu.d/
│   │   │       └── luci-app-wechatpush.json
│   │   └── wechatpush/
│   │       ├── wechatpush
│   │       └── api/
│   │           ├── *.json
│   │           └── *.list
│   └── libexec/
│       └── wechatpush-call
├── po/
│   └── zh_Hans/
│       └── wechatpush.po
├── Makefile
├── LICENSE
└── README.md
```

## 许可证

GPL-3.0

## 致谢

- 原始项目：[tty228/luci-app-wechatpush](https://github.com/tty228/luci-app-wechatpush)

## 更新日志

### v3.6.11 (2026-03-24)

- 标准化代码结构
- 修复 uci-defaults 脚本兼容性问题
- 添加中文 README

### 之前版本

- 原始版本发布

</small>
