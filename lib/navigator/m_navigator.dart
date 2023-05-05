import 'package:flutter/material.dart';

/// 注册页面
enum RouterStatus { login, register, home, detail, unknow, target, target2 }

RouterStatus getStatus(MaterialPage page) {
  return null!;
}

class RouterStatusInfo {
  final RouterStatus routerStatus;

  final Widget page;

  RouterStatusInfo(this.routerStatus, this.page);
}

/// 获取routerStatus在页面中的位置
int getPageIndex(List<MaterialPage> pages, RouterStatus routerStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routerStatus) {
      return i;
    }
  }
  return -1;
}

class MNavigator extends _RouterJumpListener {
  static MNavigator? _instance;

  MNavigator._();

  /// 记录当前页面
  RouterStatusInfo? _current;

  RouterJumpListener? _routerJump;

  RouterStatusInfo? _bottomTab;

  final List<RouterChangeListener> _listeners = [];

  static MNavigator getInstance() {
    _instance ??= MNavigator._();
    return _instance!;
  }

  /// 监听路由页面跳转
  void addListener(RouterChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// 异常监听
  void removeListener(RouterChangeListener listener) {
    _listeners.remove(listener);
  }

  void registerStatePage(Widget widget) {
    MNavigator.getInstance().addListener((current, pre) => {});
  }

  /// 注册路由跳转逻辑
  void registerRouterJump(RouterJumpListener routerJumpListener) {
    _routerJump = routerJumpListener;
  }

  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouterStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouterStatusInfo routerStatusInfo) {
    for (var listener in _listeners) {
      listener(routerStatusInfo, _current);
    }
    _current = routerStatusInfo;
  }

  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouterStatusInfo(RouterStatus.home, page);
    _notify(_bottomTab!);
  }

  @override
  void onJumpTo(RouterStatus routerStatus, {Map? args}) {
    _routerJump?.onJumpTo(routerStatus, args: args);
  }
}

/// 抽象类提供Navigator实现
abstract class _RouterJumpListener {
  void onJumpTo(RouterStatus routerStatus, {Map args});
}

typedef OnJumpTo = void Function(RouterStatus routerStatus, {Map? args});

typedef RouterChangeListener = Function(RouterStatusInfo current, RouterStatusInfo? pre);

/// 定义路由跳转逻辑
class RouterJumpListener {
  final OnJumpTo onJumpTo;

  RouterJumpListener({required this.onJumpTo});
}
