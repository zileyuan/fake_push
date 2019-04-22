# fake_push

[![Build Status](https://cloud.drone.io/api/badges/v7lin/fake_push/status.svg)](https://cloud.drone.io/v7lin/fake_push)
[![GitHub tag](https://img.shields.io/github/tag/v7lin/fake_push.svg)](https://github.com/v7lin/fake_push/releases)
[![pub package](https://img.shields.io/pub/v/fake_push.svg)](https://pub.dartlang.org/packages/fake_push)

flutter版腾讯(信鸽)推送SDK

## fake 系列 libraries

1. [flutter版okhttp3](https://github.com/v7lin/fake_http)
2. [flutter版微信SDK](https://github.com/v7lin/fake_wechat)
3. [flutter版腾讯(QQ)SDK](https://github.com/v7lin/fake_tencent)
4. [flutter版新浪微博SDK](https://github.com/v7lin/fake_weibo)
5. [flutter版支付宝SDK](https://github.com/v7lin/fake_alipay)
6. [flutter版腾讯(信鸽)推送SDK](https://github.com/v7lin/fake_push)

## dart/flutter 私服

[simple_pub_server](https://github.com/v7lin/simple_pub_server)

## android

````
# 混淆已打入 Library，随 Library 引用，自动添加到 apk 打包混淆
````

````
...
android {
    ...
    defaultConfig {
        ...
        manifestPlaceholders = [
                XG_ACCESS_ID: "${信鸽ACCESSID}",
                XG_ACCESS_KEY: "${信鸽ACCESSKEY}",
                HW_APPID: "${华为的APPID}",
                XIAOMI_APPID: "${小米的APPID}",
                XIAOMI_APPKEY: "${小米的APPKEY}",
                MEIZU_APPID: "${魅族的APPID}",
                MEIZU_APPKEY: "${魅族的APPKEY}"
        ]
        ...
    }
    ...
}
````

````
通知打开应用
notificationActionType = 1
````

## ios

````
# Capabilities
Background Modes -> Remote notifications
Push Notifications
````

````
# info 添加字段 XG_ACCESS_ID、XG_ACCESS_KEY
<key>XG_ACCESS_ID</key>
<string>${信鸽ACCESSID}</string>
<key>XG_ACCESS_KEY</key>
<string>${信鸽ACCESSKEY}</string>
````

## flutter

* snapshot

````
dependencies:
  fake_push:
    git:
      url: https://github.com/v7lin/fake_push.git
````

* release

````
dependencies:
  fake_push: ^${latestTag}
````

* example

[示例](./example/lib/main.dart)

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.io/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
