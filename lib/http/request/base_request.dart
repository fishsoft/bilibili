enum HttpMethod { POST, GET, DELETE }

abstract class BaseRequest {
  /// 域名
  String domain() {
    return "";
  }

  /// url路径参数
  var pathParams;

  /// url参数
  Map<String, String> params = Map();

  /// 请求头
  Map<String, dynamic> header = {};

  /// url请求路径
  String path();

  /// 请求方式
  HttpMethod httpMethod();

  /// 是否需要登录
  bool needLogin();

  /// 是否是https请求
  bool isHttps() {
    return true;
  }

  BaseRequest addParams(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  BaseRequest addHeather(String key, Object value) {
    header[key] = value.toString();
    return this;
  }

  /// 获取url连接
  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (pathStr.endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    /// GET请求添加参数后面连接问号
    Map<String, String> param = {};
    if (params.isNotEmpty && httpMethod() == HttpMethod.GET) {
      param.addAll(params);
    }

    if (isHttps()) {
      uri = Uri.https(domain(), pathStr, param);
    } else {
      uri = Uri.http(domain(), pathStr, param);
    }
    return uri.toString();
  }
}
