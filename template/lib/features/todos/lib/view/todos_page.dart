import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/ui_library/ui_library.api.dart';
import 'package:template/util/navigator/navigator.api.dart';

import 'package:template/util/x_arc/x_arc.api.dart';

final class TodosPage extends BasePage {
  const TodosPage({super.key});

  @override
  String get title => 'Todos';

  @override
  String get path => '/todos';

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
