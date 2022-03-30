import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WidgetSize extends StatefulWidget {
  const WidgetSize({
    Key? key,
    required this.child,
    required this.onChange,
  }) : super(key: key);

  final Widget child;
  final Function onChange;

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  GlobalKey widgetKey = GlobalKey();
  Size? oldSize;

  void postFramCallback(_) {
    if (widgetKey.currentContext == null) return;

    Size? newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback(postFramCallback);

    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }
}