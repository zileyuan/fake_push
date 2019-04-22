import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class Push {
  Push() {
    _channel.setMethodCallHandler(_handleMethod);
  }

  static const String _METHOD_ARENOTIFICATIONSENABLED =
      'areNotificationsEnabled';
  static const String _METHOD_REQUESTNOTIFICATIONSPERMISSION =
      'requestNotificationsPermission';
  static const String _METHOD_STARTWORK = 'startWork';
  static const String _METHOD_STOPWORK = 'stopWork';
  static const String _METHOD_BINDACCOUNT = 'bindAccount';
  static const String _METHOD_UNBINDACCOUNT = 'unbindAccount';
  static const String _METHOD_BINDTAGS = 'bindTags';
  static const String _METHOD_UNBINDTAGS = 'unbindTags';

  static const String _METHOD_ONNOTIFICATIONSPERMISSION =
      'onNotificationsPermission';
  static const String _METHOD_ONMESSAGE = 'onMessage';
  static const String _METHOD_ONNOTIFICATION = 'onNotification';
  static const String _METHOD_ONLAUNCHNOTIFICATION = 'onLaunchNotification';
  static const String _METHOD_ONRESUMENOTIFICATION = 'onResumeNotification';

  static const String _ARGUMENT_KEY_ENABLEDEBUG = 'enableDebug';
  static const String _ARGUMENT_KEY_ACCOUNT = 'account';
  static const String _ARGUMENT_KEY_TAGS = 'tags';

  static const MethodChannel _channel =
      MethodChannel('v7lin.github.io/fake_push');

  final StreamController<bool> _notificationsPermissionStreamController =
      StreamController<bool>.broadcast();

  final StreamController<Map<dynamic, dynamic>> _messageStreamController =
      StreamController<Map<dynamic, dynamic>>.broadcast();

  final StreamController<Map<dynamic, dynamic>> _notificationStreamController =
      StreamController<Map<dynamic, dynamic>>.broadcast();

  final StreamController<Map<dynamic, dynamic>>
      _launchNotificationStreamController =
      StreamController<Map<dynamic, dynamic>>.broadcast();

  final StreamController<Map<dynamic, dynamic>>
      _resumeNotificationStreamController =
      StreamController<Map<dynamic, dynamic>>.broadcast();

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case _METHOD_ONNOTIFICATIONSPERMISSION:
        _notificationsPermissionStreamController.add(call.arguments as bool);
        break;
      case _METHOD_ONMESSAGE:
        _messageStreamController.add(call.arguments as Map<dynamic, dynamic>);
        break;
      case _METHOD_ONNOTIFICATION:
        _notificationStreamController
            .add(call.arguments as Map<dynamic, dynamic>);
        break;
      case _METHOD_ONLAUNCHNOTIFICATION:
        _launchNotificationStreamController
            .add(call.arguments as Map<dynamic, dynamic>);
        break;
      case _METHOD_ONRESUMENOTIFICATION:
        _resumeNotificationStreamController
            .add(call.arguments as Map<dynamic, dynamic>);
        break;
    }
  }

  Future<bool> areNotificationsEnabled() {
    return _channel.invokeMethod(_METHOD_ARENOTIFICATIONSENABLED);
  }

  Future<void> requestNotificationsPermission() {
    return _channel.invokeMethod(_METHOD_REQUESTNOTIFICATIONSPERMISSION);
  }

  /// 允许通知
  Stream<bool> notificationsPermission() {
    return _notificationsPermissionStreamController.stream;
  }

  /// 开始推送
  Future<void> startWork({
    bool enableDebug = false,
  }) {
    return _channel.invokeMethod(
      _METHOD_STARTWORK,
      <String, dynamic>{
        _ARGUMENT_KEY_ENABLEDEBUG: enableDebug,
      },
    );
  }

  /// 停止推送
  Future<void> stopWork() {
    return _channel.invokeMethod(_METHOD_STOPWORK);
  }

  /// 接收透传消息（静默消息）
  Stream<Map<dynamic, dynamic>> message() {
    return _messageStreamController.stream;
  }

  /// 接收通知消息
  Stream<Map<dynamic, dynamic>> notification() {
    return _notificationStreamController.stream;
  }

  /// 接收通知栏点击事件 - 后台
  Stream<Map<dynamic, dynamic>> launchNotification() {
    return _launchNotificationStreamController.stream;
  }

  /// 接收通知栏点击事件 - 前台
  Stream<Map<dynamic, dynamic>> resumeNotification() {
    return _resumeNotificationStreamController.stream;
  }

  /// 绑定帐号
  Future<void> bindAccount({
    @required String account,
  }) {
    assert(account != null && account.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_BINDACCOUNT,
      <String, dynamic>{
        _ARGUMENT_KEY_ACCOUNT: account,
      },
    );
  }

  /// 解绑帐号
  Future<void> unbindAccount({
    @required String account,
  }) {
    assert(account != null && account.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_UNBINDACCOUNT,
      <String, dynamic>{
        _ARGUMENT_KEY_ACCOUNT: account,
      },
    );
  }

  /// 绑定标签
  Future<void> bindTags({
    @required List<String> tags,
  }) {
    assert(tags != null && tags.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_BINDTAGS,
      <String, dynamic>{
        _ARGUMENT_KEY_TAGS: tags,
      },
    );
  }

  /// 解绑标签
  Future<void> unbindTags({
    @required List<String> tags,
  }) {
    assert(tags != null && tags.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_UNBINDTAGS,
      <String, dynamic>{
        _ARGUMENT_KEY_TAGS: tags,
      },
    );
  }
}
