import 'dart:async';
import 'dart:io';

import 'package:fake_push/fake_push.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runZoned(() {
    runApp(MyApp());
  }, onError: (Object error, StackTrace stack) {
    print(error);
    print(stack);
  });

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Push push = Push();
    push.areNotificationsEnabled().then((bool isEnabled) {
      if (isEnabled) {
        push.startWork(enableDebug: !_isReleaseMode());
      } else {
        StreamSubscription<bool> _listenNotificationsPermission;
        _listenNotificationsPermission =
            push.notificationsPermission().listen((bool isEnabled) {
          if (isEnabled) {
            push.startWork(enableDebug: !_isReleaseMode());
          }
          _listenNotificationsPermission.cancel();
        });
        push.requestNotificationsPermission();
      }
    });
    return PushProvider(
      push: push,
      child: MaterialApp(
        home: Home(),
      ),
    );
  }

  bool _isReleaseMode() {
    return bool.fromEnvironment('dart.vm.product');
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PushWidget(
      push: PushProvider.of(context).push,
      messageHandler: _handleMessage,
      notificationHandler: _handleNotification,
      launchNotificationHandler: _handleLaunchNotificationHandler,
      resumeNotificationHandler: _handleResumeNotificationHandler,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Fake Push Demo'),
          ),
          body: Center(
            child: GestureDetector(
              child: Text('${Platform.operatingSystem}'),
              onTap: () {},
            ),
          ),
        );
      },
    );
  }

  void _handleMessage(Map<dynamic, dynamic> map) {
    print('message $map');
  }

  void _handleNotification(Map<dynamic, dynamic> map) {
    print('notification $map');
  }

  void _handleLaunchNotificationHandler(Map<dynamic, dynamic> map) {
    print('launchNotification $map');
  }

  void _handleResumeNotificationHandler(Map<dynamic, dynamic> map) {
    print('resumeNotification $map');
  }
}
