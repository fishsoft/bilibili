import 'package:bilibili/dao/user_dao.dart';
import 'package:bilibili/http/core/net_error.dart';
import 'package:bilibili/navigator/m_navigator.dart';
import 'package:bilibili/utils/string_utils.dart';
import 'package:bilibili/widget/login_input.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/login_button.dart';
import 'package:bilibili/widget/login_effect.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('密码登录', '注册', () {
        MNavigator.getInstance().onJumpTo(RouterStatus.register);
      }),
      body: ListView(
        children: [
          LoginEffect(protect: protect),
          LoginInput(
            '用户名',
            '请输入用户名',
            onChange: (text) {
              userName = text;
              checkInput();
            },
          ),
          LoginInput(
            '密码',
            '请输入密码',
            obscureText: true,
            onChange: (text) {
              password = text;
              checkInput();
            },
            focusChanged: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: LoginButton(
              '登录',
              enanble: loginEnable,
              onPressed: send,
            ),
          )
        ],
      ),
    );
  }

  checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    print("object");
    try {
      var result = await UserDao.login(userName!, password!);

      if (result['code'] == 0) {
        print("登录成功");
      } else {
        print(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
    } on MNetError catch (e) {
      print(e);
    }
  }
}
