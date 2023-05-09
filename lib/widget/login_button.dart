import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enanble;
  final VoidCallback? onPressed;

  LoginButton(this.title, {Key? key, this.enanble = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
        onPressed: enanble ? onPressed : null,
        disabledColor: Colors.pink[50],
        color: Colors.pink,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
