import 'package:bilibili/navigator/m_navigator.dart';
import 'package:bilibili/pages/home_page.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigatorState();
  }
}

class _BottomNavigatorState extends State<BottomNavigator> {
  late List<Widget> _pages;

  static int initialPage = 0;

  int _currentPage = 0;

  final _defaultColor = Colors.grey;

  final _activeColor = Colors.pink;

  final PageController _controller = PageController(initialPage: initialPage);

  @override
  Widget build(BuildContext context) {
    _pages = [const HomePage()];
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,

        /// 禁止手动滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) => _onJumpTo(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('排行', Icons.local_fire_department, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.live_tv, 3),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        label: title);
  }

  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      _controller.jumpToPage(index);
    } else {
      MNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      _currentPage = index;
    });
  }
}
