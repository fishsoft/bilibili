import 'package:bilibili/http/core/adapter/net_adapter.dart';
import 'package:bilibili/http/core/net_error.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DioAdapter extends MNetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    var response;

    var error;

    var url = request.url();

    var httpMethod = request.httpMethod();

    try {
      if (httpMethod == HttpMethod.GET) {
        response = await http.get(url);
      } else if (httpMethod == HttpMethod.POST) {
        response = await http.post(url, body: request.params);
      } else if (httpMethod == HttpMethod.DELETE) {
        response = await http.delete(url, body: request.params);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response as http.Response;
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
