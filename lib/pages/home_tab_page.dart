import 'package:bilibili/api/video.dart';
import 'package:bilibili/banner/banner.dart';
import 'package:bilibili/base/base_state.dart';
import 'package:bilibili/dao/home_dao.dart';
import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/widget/loading_container.dart';
import 'package:bilibili/widget/video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String name;

  const HomeTabPage({Key? key, required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeTabPageState();
  }
}

class _HomeTabPageState extends BaseState<HomeTabPage> {
  final ScrollController _scrollController = ScrollController();

  List<HomeMo> data = [];

  List<VideoModel> _videos = videos.toList();

  int pageIndex = 0;

  int pageSize = 10;

  bool _isLoading = true;

  @override
  void initState() {
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      if (dis < 300) {
        print('------_loadData---');
        _loadData(loadMore: true);
      }
    });
    _loadData();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingContainer(
        isLoading: _isLoading,
        child: RefreshIndicator(
          color: Colors.pink,
          onRefresh: _loadData,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: StaggeredGridView.countBuilder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              itemCount: data.length,
              crossAxisCount: 2,
              itemBuilder: (BuildContext ctx, int index) {
                if (index == 0) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _banner());
                } else {
                  return VideoCard(data: _videos[index]);
                }
              },
              staggeredTileBuilder: (int index) {
                if (index == 0) {
                  return const StaggeredTile.fit(2);
                } else {
                  return const StaggeredTile.fit(1);
                }
              },
            ),
          ),
        ));
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: MBanner(data.sublist(0, 5)!),
    );
  }

  Future<void> _loadData({loadMore = false}) async {
    print("_loadData:$loadMore");
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    List<HomeMo> homeData = await HomeDao.loadHomeRecommend(0,
        pageSize: pageSize, pageIndex: currentIndex);
    setState(() {
      data = [...data, ...homeData];
      if (homeData.isNotEmpty) {
        pageIndex++;
      }
      _isLoading = false;
    });
  }
}
