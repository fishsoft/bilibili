import 'package:bilibili/http/core/adapter/dio_adapter.dart';
import 'package:bilibili/http/core/adapter/net_adapter.dart';
import 'package:bilibili/http/core/net_error.dart';
import 'package:bilibili/http/request/base_request.dart';

/// 支持网络插件设计请不干扰业务
/// 基于配置请求，简洁易用
/// adapter设计，拓展性强
/// 统一异常和响应处理

class MNet {
  MNet._();

  static MNet? instance;

  static MNet getInstance() {
    instance ??= MNet._();
    return instance!;
  }

  Future fire(BaseRequest request) async {
    NetResponse? response;
    var error;
    try {
      response = await send(request);
    } on MNetError catch(e){
      error = e;
      response = e.data;
      _printLog(e.message);
    } catch (e){
      error = e;
      _printLog(e);
    }
    if (response == null) {
      _printLog(error);
    }
    var result = response?.data;
    _printLog(result);
    var status = response?.statusCode;
    switch(status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw MNetError(status ?? -1, result.toString(), data: result);
    }
    return null;
  }

  Future<NetResponse<T>?> send<T>(BaseRequest request) async {
    MNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void _printLog(log) {
    print('fw_net:$log');
  }
}