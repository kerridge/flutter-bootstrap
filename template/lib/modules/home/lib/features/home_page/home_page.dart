import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/modules/home/lib/module/home.routes.dart';
import 'package:template/modules/todos/todos.api.dart';
import 'package:template/ui_library/ui_library.api.dart';
import 'package:template/util/x_arc/x_arc.api.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  String get title => 'Home';

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UITextButton(
          label: 'Push to Todos List',
          onPressed: () {
            TodoRoutes.todosList.push(context);
          },
        ),
        const SizedBox(height: 10),
        UITextButton(
          label: 'Go to Todo 1',
          onPressed: () {
            TodoRoutes.todoDetail('1').go(context);
          },
        ),
      ],
    ).size(width: 500).center();
  }
}
