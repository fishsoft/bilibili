import 'package:bilibili/base/base_state.dart';
import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/pages/home_tab_page.dart';
import 'package:bilibili/utils/view_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends BaseState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  late TabController _controller;

  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];

  List<HomeMo>? data;

  @override
  void initState() {
    super.initState();
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: _tabBar(),
          ),
          Flexible(
              child: TabBarView(
                  controller: _controller,
                  children: tabs.map((tab) {
                    return HomeTabPage(name: tab);
                  }).toList()))
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        changeStatusBar();
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  _tabBar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        labelColor: Colors.black,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(color: Colors.pink, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15),
        ),
        tabs: tabs.map((tab) {
          return Tab(
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(
                tab,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList());
  }
}
