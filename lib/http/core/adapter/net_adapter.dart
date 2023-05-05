import 'package:bilibili/http/request/base_request.dart';

abstract class MNetAdapter {
  Future<NetResponse<T>> send<T>(BaseRequest request);
}

class NetResponse<T> {
  T? data;

  BaseRequest request;

  int? statusCode;

  String? statusMessage;

  late dynamic extra;

  NetResponse(
      {this.data,
      required this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});
}
