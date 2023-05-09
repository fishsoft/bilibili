import 'package:bilibili/utils/view_utils.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

/// 自定义播放组件
class VideoPlayer extends StatefulWidget {
  /// 播放连接
  final String url;
  final String cover;

  /// 自动播放
  final bool autoPlay;

  /// 循环播放
  final bool looping;

  /// 视频比例
  final double aspectRatio;
  final Widget? overlayUI;

  const VideoPlayer(this.url,
      {Key? key,
      required this.cover,
      this.autoPlay = false,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerState();
  }
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  get _placeholder => FractionallySizedBox(
        widthFactor: 1,
        child: cacheImage(widget.cover),
      );

  get _progressColors => ChewieProgressColors(
      playedColor: Colors.pink,
      handleColor: Colors.pink,
      backgroundColor: Colors.grey,
      bufferedColor: Colors.pink[50]!);

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        placeholder: _placeholder,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        customControls: MaterialControls(),
        materialProgressColors: _progressColors);
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
