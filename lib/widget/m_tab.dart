import 'package:flutter/material.dart';

class MTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unSelectedLabelColor;

  const MTab(this.tabs,
      {Key? key,
      this.controller,
      this.fontSize = 13,
      this.borderWidth = 2,
      this.insets = 15,
      this.unSelectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: Colors.pink,
        unselectedLabelColor: unSelectedLabelColor,
        labelStyle: TextStyle(fontSize: fontSize),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.pink, width: borderWidth),
          insets: EdgeInsets.only(left: insets, right: insets),
        ),
        tabs: tabs);
  }
}
