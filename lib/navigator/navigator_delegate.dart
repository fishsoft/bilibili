import 'package:bilibili/dao/user_dao.dart';
import 'package:bilibili/http/core/m_net.dart';
import 'package:bilibili/http/core/net_error.dart';
import 'package:bilibili/navigator/m_navigator.dart';
import 'package:bilibili/navigator/route_path.dart';
import 'package:bilibili/pages/home_page.dart';
import 'package:bilibili/pages/login_page.dart';
import 'package:bilibili/pages/register_page.dart';
import 'package:bilibili/pages/video_detail_page.dart';
import 'package:flutter/material.dart';

class NavigatorDelegate extends RouterDelegate<MRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<MRouterPath> {
  MRouterPath? path;

  List<MaterialPage> pages = [];

  RouterStatus _routerStatus = RouterStatus.home;

  RouterStatus get routerStatus {
    if (_routerStatus != RouterStatus.register && !hasLogin) {
      return _routerStatus = RouterStatus.login;
    }
    return _routerStatus;
  }

  bool get hasLogin => UserDao.getToken() != null;

  Map? _args;

  managerStack() {
    /// 获取栈区中的位置
    var index = getPageIndex(pages, routerStatus);

    /// 截取栈区
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page = getPage(routerStatus);

    tempPages = [...tempPages, page];
    pages = tempPages;
  }

  MaterialPage pageWrapper(Widget child) {
    return MaterialPage(child: child, key: ValueKey(child.hashCode));
  }

  MaterialPage getPage(RouterStatus status) {
    switch (status) {
      case RouterStatus.login:
        print("getPage login");
        return pageWrapper(const LoginPage());
      case RouterStatus.home:
        print("getPage home");
        return pageWrapper(const HomePage());
      case RouterStatus.register:
        print("getPage register");
        return pageWrapper(const RegisterPage());
      case RouterStatus.detail:
        print("getPage detail");
        return pageWrapper(VideoDetailPage(_args?["video"]));
    }
  }

  /// 页面处理
  @override
  Widget build(BuildContext context) {
    managerStack();
    return WillPopScope(
        child: Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (router, result) {
            /// false不出栈，true出栈，如果栈内没有page，不需要弹栈
            if (router.didPop(result)) {
              return false;
            }

            var tempPages = [...pages];
            pages.removeLast();

            /// 关闭页面
            MNavigator.getInstance().notify(pages, tempPages);

            return true;
          },
        ),
        onWillPop: () async =>
            !(await navigatorKey?.currentState?.maybePop() ?? false));
  }

  NavigatorDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    print("navigator delegate");
    MNavigator.getInstance().registerRouterJump(
        RouterJumpListener(onJumpTo: (RouterStatus routerStatus, {Map? args}) {
      _routerStatus = routerStatus;
      _args = args;
      notifyListeners();
    }));

    /// 设置网络错误拦截器
    MNet.getInstance()
        .setErrorInterceptor((error) => {if (error is NeedLogin) {}});
  }

  @override
  // TODO: implement navigatorKey
  GlobalKey<NavigatorState>? navigatorKey;

  @override
  Future<void> setNewRoutePath(MRouterPath configuration) async {
    path = configuration;
  }
}
