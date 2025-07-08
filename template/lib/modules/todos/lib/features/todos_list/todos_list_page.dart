import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/ui_library/ui_library.api.dart';
import 'package:template/util/navigator/navigator.api.dart';

import 'package:template/util/x_arc/x_arc.api.dart';

final class TodosListPage extends BasePage {
  const TodosListPage({super.key});

  @override
  String get title => 'Todos';

  @override
  PreferredSizeWidget? buildAppBar(
    BuildContext context,
    WidgetRef ref,
    AppRouter router,
  ) => AppBar(title: Text(title));

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, AppRouter router) {
    return UITextButton(
      label: 'Pop',
      onPressed: () {
        ref.router.pop(context);
      },
    ).size(width: 200).center();
  }
}
