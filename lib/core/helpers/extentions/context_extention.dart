import 'package:flutter/cupertino.dart';

extension NavigatorContext on BuildContext{
  Future<void> pushNamed(String routeName,{Object? arguments})async {
    Navigator.of(this).pushNamed(routeName,arguments: arguments);
  }
  Future<void> pushAndRemoveUntil(String routeName, {Object? arguments}) async {
    await Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
          (route) => false,
      arguments: arguments,
    );
  }
}