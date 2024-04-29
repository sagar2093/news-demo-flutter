import 'package:alice/alice.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../get_it.dart';

class DevWidget extends StatelessWidget {
  const DevWidget({
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    super.key,
  });

  final Widget child;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onDoubleTap: onDoubleTap ??
          (kReleaseMode
              ? null
              : () async {
                  getIt<Alice>().showInspector();
                }),
      child: child,
    );
  }
}
