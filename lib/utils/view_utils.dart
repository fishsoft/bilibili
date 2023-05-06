import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
