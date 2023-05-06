import './base_request.dart';

//首页推荐视频
class HomeVideoRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "recommend";
  }

  @override
  bool isHttps() {
    return false;
  }
}

class HomeTypesRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "recommend";
  }
}
