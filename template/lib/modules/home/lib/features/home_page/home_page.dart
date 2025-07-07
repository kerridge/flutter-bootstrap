import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/modules/home/lib/module/home.routes.dart';
import 'package:template/ui_library/ui_library.api.dart';
import 'package:template/util/x_arc/x_arc.api.dart';
import 'package:template/util/navigator/lib/routers/router.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  String get title => 'Home';

  @override
  String get path => '/home';

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, AppRouter router) {
    return SizedBox(
      width: 200,
      child: UITextButton(
        label: 'Push page',
        onPressed: () {
          HomeRoutes.home.go(context);
          // ref.router.push(context, HomeRoutes.home.path);
        },
      ),
    ).center();
  }
}
