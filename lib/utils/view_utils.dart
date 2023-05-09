import 'dart:io';

import 'package:bilibili/utils/format_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

Widget cacheImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    placeholder: (BuildContext context, String url) => Container(
      color: Colors.grey[200],
    ),
    errorWidget: (BuildContext ctx, String url, dynamic error) =>
        const Icon(Icons.error),
  );
}

blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: const [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent
      ]);
}

///修改状态栏
void changeStatusBar(
    {color: Colors.white,
    StatusStyle statusStyle: StatusStyle.DARK_CONTENT,
    BuildContext? context}) {
  //沉浸式状态栏样式
  Brightness brightness = statusStyle == StatusStyle.LIGHT_CONTENT
      ? Brightness.dark
      : Brightness.light;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: brightness,
    statusBarIconBrightness: brightness,
  ));
}

smallIconText(IconData iconData, var text) {
  var style = const TextStyle(fontSize: 12, color: Colors.grey);
  if (text is int) {
    text = countFormat(text);
  }
  return [
    Icon(
      iconData,
      color: Colors.grey,
      size: 12,
    ),
    Text(
      ' $text',
      style: style,
    )
  ];
}

borderLine(BuildContext context, {bottom: true, top: false}) {
  BorderSide borderSide = BorderSide(width: 0.5, color: Colors.grey[200]!);
  return Border(
    bottom: bottom ? borderSide : BorderSide.none,
    top: top ? borderSide : BorderSide.none,
  );
}

SizedBox hiSpace({double height: 1, double width: 1}) {
  return SizedBox(
    height: height,
    width: width,
  );
}
