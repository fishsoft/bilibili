import 'package:bilibili/api/video.dart';
import 'package:bilibili/model/home_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/navigator/m_navigator.dart';
import 'package:bilibili/utils/format_utils.dart';
import 'package:bilibili/utils/view_utils.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final VideoModel data;

  const VideoCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("VideoCard onClick");
        MNavigator.getInstance()
            .onJumpTo(RouterStatus.detail, args: {"video": data});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          margin: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_itemImage(context), _infoText()],
            ),
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        cacheImage(data.cover, width: size.width / 2 - 10, height: 120),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 3, top: 5),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconText(Icons.ondemand_video, data.view),
                  _iconText(Icons.favorite_border, data.favorite),
                  _iconText(null, data.duration),
                ],
              ),
            ))
      ],
    );
  }

  _iconText(IconData? iconData, int count) {
    String durations = "";
    if (iconData != null) {
      durations = countFormat(count);
    } else {
      durations = durationTransform(data.duration);
    }
    return Row(
      children: [
        if (iconData != null)
          Icon(
            iconData,
            color: Colors.white,
            size: 12,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Text(
            durations,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        )
      ],
    );
  }

  _infoText() {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _owner()
        ],
      ),
    ));
  }

  _owner() {
    var owner = data.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: cacheImage(owner.face, height: 24, width: 24),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                owner.name,
                style: const TextStyle(fontSize: 11, color: Colors.black87),
              ),
            )
          ],
        ),
        const Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        )
      ],
    );
  }
}
