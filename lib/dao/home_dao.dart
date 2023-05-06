import 'dart:convert';

import 'package:bilibili/http/core/m_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/model/home_model.dart';

import '../http/request/home_request.dart';

class HomeDao {
  static const AUTHORIZATION = "authorization";
  static const LOGIN = 0;
  static const REGISTER = 1;

  static loadHomeRecommend(int tid,
      {int pageIndex = 1, int pageSize = 1}) async {
    print("当前TID:$tid");
    BaseRequest request = HomeVideoRequest();
    request
        .addParams("tid", tid)
        .addParams("pageIndex", pageIndex)
        .addParams("pageSize", pageSize);
    var result = await MNet.getInstance().fire(request);
    return ResponseData.fromJson(result).list;
  }
}
