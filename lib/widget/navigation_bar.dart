import 'package:bilibili/utils/view_utils.dart';
import 'package:flutter/material.dart';

class NavigationBarPlus extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const NavigationBarPlus(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _statusBarInit();
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: top + height,
      child: child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }

  void _statusBarInit() {
    changeStatusBar(color: color, statusStyle: statusStyle);
  }
}
