import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class NavigatorHandler {
  void push(BuildContext context, String routeName, {Object? arguments});
  void pushNamedAndRemoveUntil(
      BuildContext context, String routeName, String untilRouteName,
      {Object? arguments});
  void pushReplacementNamed(BuildContext context, String routeName,
      {Object? arguments});
  void pop(BuildContext context);
}

class NavigatorHandlerImpl implements NavigatorHandler {
  @override
  void push(BuildContext context, String routeName, {Object? arguments}) {
    context.go(routeName, extra: arguments);
  }

  @override
  void pushNamedAndRemoveUntil(
      BuildContext context, String routeName, String untilRouteName,
      {Object? arguments}) {
    context.goNamed(routeName, extra: arguments);
  }

  @override
  void pushReplacementNamed(BuildContext context, String routeName,
      {Object? arguments}) {
    context.replace(routeName, extra: arguments);
  }

  @override
  void pop(BuildContext context) {
    context.pop();
  }
}
