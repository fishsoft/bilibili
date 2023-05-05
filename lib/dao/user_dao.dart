import 'package:bilibili/cache/MCache.dart';
import 'package:bilibili/http/core/m_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/user_request.dart';

class UserDao {
  static const AUTHORIZATION = "authorization";
  static const LOGIN = 0;
  static const REGISER = 1;

  static login(String name, String pwd) {
    return _send(name, pwd, LOGIN);
  }

  static register(String name, String pwd) {
    return _send(name, pwd, REGISER);
  }

  static _send(String userName, String pwd, int requestCode) async {
    BaseRequest request;
    switch (requestCode) {
      case LOGIN:
        request = LoginRequest();
        break;
      case REGISER:
        request = RegisterRequest();
        break;
      default:
        return;
    }
    request.addParams("userName", userName).addParams("password", pwd);
    var result = await MNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      MCache.getInstance()
          .setString(request.getAuthorization(), result['data']);
    }
    print("token:${getToken()}");
    return result;
  }

  static getToken() {
    return MCache.getInstance().get(AUTHORIZATION);
  }
}
