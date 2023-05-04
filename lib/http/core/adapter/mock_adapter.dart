import 'package:bilibili/http/request/base_request.dart';

import 'net_adapter.dart';

///测试适配器，mock数据
class MockAdapter extends MNetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return NetResponse(
          request: request,
          data: {"code": 0, "message": 'success'} as T,
          statusCode: 200);
    });
  }
}
