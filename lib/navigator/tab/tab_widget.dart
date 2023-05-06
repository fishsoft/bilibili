import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  List<String> tabs;

  TabWidget({Key? key, required this.tabs}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabWidgetState();
  }
}

class _TabWidgetState extends State<TabWidget>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
