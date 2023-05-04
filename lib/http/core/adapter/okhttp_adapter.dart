import 'package:bilibili/http/core/adapter/net_adapter.dart';
import 'package:bilibili/http/core/net_error.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:dio/dio.dart';

class DioAdapter extends MNetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);

    var error;

    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw MNetError(response?.statusCode ?? -1, error.toString(),
          data: await buildResponse(response, request));
    }
    return buildResponse(response, request);
  }

  ///构建FwNetResponse
  Future<NetResponse<T>> buildResponse<T>(
      Response? response, BaseRequest request) {
    return Future.value(NetResponse(
        //?.防止response为空
        data: response?.data,
        request: request,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response));
  }
}
