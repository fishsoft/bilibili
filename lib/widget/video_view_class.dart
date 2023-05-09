import 'package:bilibili/utils/view_utils.dart';
import 'package:bilibili/widget/player/video_controls.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewClass extends StatefulWidget {
  final String url;

  // 封面图片
  final String cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUI;

  const VideoViewClass(this.url,
      {Key? key,
      required this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoViewClassState();
  }
}

class _VideoViewClassState extends State<VideoViewClass> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        customControls: MaterialControls(
            showLoadingOnInitialize: false,
            showBigPlayIcon: false,
            bottomGradient: blackLinearGradient(),
            overlayUI: widget.overlayUI));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(controller: _chewieController),
    );
  }
}
