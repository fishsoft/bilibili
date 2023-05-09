import 'package:bilibili/navigator/m_navigator.dart';
import 'package:bilibili/utils/string_utils.dart';
import 'package:bilibili/widget/login_input.dart';
import 'package:bilibili/widget/appbar.dart';
import 'package:bilibili/widget/login_button.dart';
import 'package:bilibili/widget/login_effect.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  bool protect = false;
  bool loginEnable = false;
  String? userName;
  String? password;
  String? rePassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("注册", "登录", () {
        MNavigator.getInstance().onJumpTo(RouterStatus.login);
      }),
      body: ListView(
        //自适应键盘弹起，防止遮挡
        children: [
          LoginEffect(
            protect: protect,
          ),
          LoginInput(
            "用户名",
            "请输入用户名",
            onChange: (text) {
              userName = text;
              checkInput();
            },
          ),
          LoginInput(
            "密码",
            "请输入密码",
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
          LoginInput(
            "确认密码",
            "请再次输入密码",
            lineStretch: true,
            obscureText: true,
            onChange: (text) {
              rePassword = text;
              checkInput();
            },
            focusChanged: (focus) {
              setState(() {
                protect = focus;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child:
                LoginButton('注册', enanble: loginEnable, onPressed: checkParams),
          )
        ],
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    // try {
    //   var result =
    //       await LoginDao.registration(userName!, password!, imoocId!, orderId!);
    //   print(result);
    //   if (result['code'] == 0) {
    //     print('注册成功');
    //     showToast('注册成功');
    //     if (widget.onJumpToLogin != null) {
    //       widget.onJumpToLogin!();
    //     }
    //   } else {
    //     print(result['msg']);
    //     showWarnToast(result['msg']);
    //   }
    // } on NeedAuth catch (e) {
    //   print(e);
    //   showWarnToast(e.message);
    // } on FwNetError catch (e) {
    //   print(e);
    //   showWarnToast(e.message);
    // }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = '两次密码不一致';
    }
    if (tips != null) {
      print(tips);
      return;
    }
    send();
  }
}
