import 'package:bilibili/http/core/adapter/net_adapter.dart';
import 'package:bilibili/http/core/net_error.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:dio/dio.dart';

class DioAdapter extends MNetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);

    var error;

    HttpMethod method = request.httpMethod();
    var url = request.url().toString();
    try {
      if (method == HttpMethod.GET) {
        response = await Dio().get(url, options: options);
      } else if (method == HttpMethod.POST) {
        response =
            await Dio().post(url, data: request.params, options: options);
      } else if (method == HttpMethod.DELETE) {
        response =
            await Dio().delete(url, data: request.params, options: options);
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

  Future<NetResponse<T>> buildResponse<T>(
      Response? response, BaseRequest request) {
    return Future.value(NetResponse(
        request: request,
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
        extra: response?.extra));
  }
}
