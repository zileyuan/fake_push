import 'package:fake_push/src/push.dart';
import 'package:flutter/widgets.dart';

class PushProvider extends InheritedWidget {
  PushProvider({
    Key key,
    @required this.push,
    @required Widget child,
  }) : super(key: key, child: child);

  final Push push;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    PushProvider oldProvider = oldWidget as PushProvider;
    return push != oldProvider.push;
  }

  static PushProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(PushProvider) as PushProvider;
  }
}
