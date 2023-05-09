import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;

  /// 输入框数据变化
  final ValueChanged<String>? onChange;

  /// 输入框焦点变化
  final ValueChanged<bool>? focusChanged;

  /// 底部想是否整行
  final bool lineStretch;

  /// 是否是启用密码输入模式
  final bool obscureText;

  /// 输入框类型
  final TextInputType? keyboardType;

  LoginInput(this.title, this.hint,
      {Key? key,
      this.onChange,
      this.focusChanged,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginInputState();
  }
}

class _LoginInputState extends State<LoginInput> {
  /// 获取光标组件
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChange,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
