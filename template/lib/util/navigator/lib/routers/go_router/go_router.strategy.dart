import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';

final class GoRouterStrategy implements AppRouter {
  @override
  void push(BuildContext context, String path) {
    GoRouter.of(context).push(path);
  }

  @override
  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void showBottomSheet(BuildContext context, WidgetBuilder builder) {
    showModalBottomSheet(context: context, builder: builder);
  }

  @override
  void displayDialog(BuildContext context, WidgetBuilder builder) {
    showDialog(context: context, builder: builder);
  }
}
