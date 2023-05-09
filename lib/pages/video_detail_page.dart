import 'dart:io';

import 'package:bilibili/api/video.dart';
import 'package:bilibili/model/video_detail_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/utils/view_utils.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/expandable_content.dart';
import 'package:bilibili/widget/m_tab.dart';
import 'package:bilibili/widget/navigation_bar.dart';
import 'package:bilibili/widget/video_header.dart';
import 'package:bilibili/widget/video_large_card.dart';
import 'package:bilibili/widget/video_toolbar.dart';
import 'package:bilibili/widget/video_view_class.dart';
import 'package:flutter/material.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage(this.videoModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoDetailState();
  }
}

class _VideoDetailState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  late TabController _controller;

  List tabs = ["简介", "评论288"];
  VideoDetailMo? videoDetailMo;
  VideoModel? videoModel;
  List<VideoModel> videoList = videos.toList();

  @override
  void initState() {
    super.initState();
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _controller = TabController(length: tabs.length, vsync: this);
    videoModel = widget.videoModel;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
          context: context,
          child: videoModel?.url != null
              ? Column(
                  children: [
                    NavigationBarPlus(
                      color: Colors.black,
                      statusStyle: StatusStyle.LIGHT_CONTENT,
                      height: Platform.isAndroid ? 0 : 46,
                      child: Container(),
                    ),
                    _buildVideoView(),
                    _buildTabNavigation(),
                    Flexible(
                        child: TabBarView(
                      controller: _controller,
                      children: [_buildDetailList(), const Text('敬请期待...')],
                    ))
                  ],
                )
              : Container()),
    );
  }

  _buildVideoView() {
    var model = videoModel;
    return VideoViewClass(
      model!.url!,
      cover: model.cover,
      overlayUI: videoAppBar(),
    );
  }

  _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return MTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),
      controller: _controller,
    );
  }

  _buildDetailList() {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [...buildContents(), ..._buildDetailList()],
    );
  }

  buildContents() {
    return [
      VideoHeader(owner: videoModel!.owner),
      ExpandableContent(mo: videoModel!),
      VideoToolBar(
        detailMo: videoDetailMo,
        videoModel: videoModel!,
        onLike: _doLike,
        onUnlike: _onUnlike,
        onFavorite: _onFavorite,
      )
    ];
  }

  void _loadDetail() async {}

  _doLike() async {}

  void _onUnlike() {}

  void _onFavorite() async {}

  _buildVideoList() {
    return videoList
        .map((VideoModel mo) => VideoLargeCard(videoModel: mo))
        .toList();
  }
}
