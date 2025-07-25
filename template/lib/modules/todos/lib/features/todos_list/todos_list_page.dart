import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/ui_library/ui_library.api.dart';
import 'package:template/util/module/module.dart';
import 'package:template/util/navigation/navigation.api.dart';

import 'package:template/util/x_arc/x_arc.api.dart';

import '../../module/todo.routes.dart';

final class TodosListPage extends BasePage {
  const TodosListPage({super.key});

  @override
  String get title => 'Todos';

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      AppBar(title: Text(title));

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UITextButton(
          label: 'todo 1',
          onPressed: () {
            // TodoRoutes.todoDetail('1').push(context);
            context.push(TodoRoutes.todoDetail('1').location);
          },
        ).size(width: 200).center(),
      ],
    );
  }
}
