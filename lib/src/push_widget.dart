import 'dart:async';

import 'package:fake_push/src/push.dart';
import 'package:fake_push/src/push_foundation.dart';
import 'package:flutter/widgets.dart';

class PushWidget extends StatefulWidget {
  PushWidget({
    Key key,
    @required this.push,
    this.messageHandler,
    this.notificationHandler,
    this.launchNotificationHandler,
    this.resumeNotificationHandler,
    @required this.builder,
  })  : assert(push != null),
        assert(builder != null),
        super(key: key);
  final Push push;
  final PushMessageHandler messageHandler;
  final PushMessageHandler notificationHandler;
  final PushMessageHandler launchNotificationHandler;
  final PushMessageHandler resumeNotificationHandler;
  final WidgetBuilder builder;

  @override
  State<StatefulWidget> createState() {
    return _PushWidgetState();
  }
}

class _PushWidgetState extends State<PushWidget> {
  StreamSubscription<Map<dynamic, dynamic>> _message;
  StreamSubscription<Map<dynamic, dynamic>> _notification;
  StreamSubscription<Map<dynamic, dynamic>> _launchNotification;
  StreamSubscription<Map<dynamic, dynamic>> _resumeNotification;

  @override
  void initState() {
    super.initState();
    if (widget.messageHandler != null) {
      _message = widget.push.message().listen(widget.messageHandler);
    }
    if (widget.notificationHandler != null) {
      _notification =
          widget.push.notification().listen(widget.notificationHandler);
    }
    if (widget.launchNotificationHandler != null) {
      _launchNotification = widget.push
          .launchNotification()
          .listen(widget.launchNotificationHandler);
    }
    if (widget.resumeNotificationHandler != null) {
      _resumeNotification = widget.push
          .resumeNotification()
          .listen(widget.resumeNotificationHandler);
    }
  }

  @override
  void dispose() {
    if (_message != null) {
      _message.cancel();
    }
    if (_notification != null) {
      _notification.cancel();
    }
    if (_launchNotification != null) {
      _launchNotification.cancel();
    }
    if (_resumeNotification != null) {
      _resumeNotification.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
