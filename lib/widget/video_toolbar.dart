import 'package:bilibili/model/video_detail_model.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/utils/format_utils.dart';
import 'package:bilibili/utils/view_utils.dart';
import 'package:flutter/material.dart';

class VideoToolBar extends StatelessWidget {
  final VideoDetailMo? detailMo;
  final VideoModel videoModel;
  final VoidCallback? onLike;
  final VoidCallback? onUnlike;
  final VoidCallback? onCoin;
  final VoidCallback? onFavorite;
  final VoidCallback? onShare;

  const VideoToolBar(
      {Key? key,
      this.detailMo,
      required this.videoModel,
      this.onLike,
      this.onUnlike,
      this.onCoin,
      this.onFavorite,
      this.onShare})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: borderLine(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded, videoModel.like,
              onClick: onLike, tint: detailMo?.isLike ?? false),
          _buildIconText(Icons.thumb_down_alt_rounded, '不喜欢',
              onClick: onUnlike),
          _buildIconText(Icons.monetization_on, videoModel.coin,
              onClick: onCoin),
          _buildIconText(Icons.grade_rounded, videoModel.favorite,
              onClick: onFavorite, tint: detailMo?.isFavorite ?? false),
          _buildIconText(Icons.share_rounded, videoModel.share,
              onClick: onShare),
        ],
      ),
    );
  }

  _buildIconText(IconData iconData, text, {onClick, bool tint = false}) {
    if (text is int) {
      text = countFormat(text);
    } else {
      text ??= '';
    }
    tint = tint == null ? false : tint;
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Icon(
            iconData,
            color: tint ? Colors.pink : Colors.grey,
            size: 20,
          ),
          hiSpace(height: 5),
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
