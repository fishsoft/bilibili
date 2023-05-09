import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/navigator/m_navigator.dart';
import 'package:bilibili/utils/format_utils.dart';
import 'package:bilibili/utils/view_utils.dart';
import 'package:flutter/material.dart';

class VideoLargeCard extends StatelessWidget {
  final VideoModel videoModel;

  const VideoLargeCard({Key? key, required this.videoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MNavigator.getInstance()
            .onJumpTo(RouterStatus.detail, args: {"videoMo": videoModel});
      },
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
        padding: const EdgeInsets.only(bottom: 6),
        height: 106,
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            _itemImage(context),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    double height = 90;
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Stack(
        children: [
          cacheImage(videoModel.cover,
              width: height * (16 / 9), height: height),
          Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  durationTransform(videoModel.duration),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ))
        ],
      ),
    );
  }

  _buildContent() {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(top: 5, left: 8, bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoModel.title,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _buildBottomContent()
        ],
      ),
    ));
  }

  _buildBottomContent() {
    return Expanded(
        child: Column(
      children: [
        _owner(),
        hiSpace(height: 5),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...smallIconText(Icons.ondemand_video, videoModel.view),
                hiSpace(width: 5),
                ...smallIconText(Icons.list_alt, videoModel.reply)
              ],
            ),
            const Icon(
              Icons.more_vert_rounded,
              color: Colors.grey,
              size: 15,
            )
          ],
        ))
      ],
    ));
  }

  _owner() {
    var owner = videoModel.owner;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.grey),
          ),
          child: const Text(
            'UP',
            style: TextStyle(
                color: Colors.grey, fontSize: 8, fontWeight: FontWeight.bold),
          ),
        ),
        hiSpace(width: 8),
        Text(
          owner.name,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        )
      ],
    );
  }
}
