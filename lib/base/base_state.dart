import 'package:flutter/cupertino.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      print("page has destroy");
    }
  }
}
