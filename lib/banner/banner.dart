import 'package:bilibili/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class MBanner extends StatelessWidget {
  final List<HomeMo> _bannerList;

  final double bannerHeight;

  final EdgeInsetsGeometry? padding;

  const MBanner(this._bannerList,
      {super.key, this.bannerHeight = 160, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      autoplay: true,
      itemBuilder: (BuildContext ctx, int index) {
        return _image(_bannerList[index]);
      },
      itemCount: _bannerList.length,
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: const DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6)),
    );
  }

  _image(HomeMo mo) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            mo.pic ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
