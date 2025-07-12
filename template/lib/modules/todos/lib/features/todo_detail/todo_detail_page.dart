import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/ui_library/ui_library.api.dart';

import 'package:template/util/x_arc/x_arc.api.dart';

final class TodoDetailPage extends BasePage {
  const TodoDetailPage({super.key, required this.id});

  final String id;

  @override
  String get title => 'Todo $id';

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context, WidgetRef ref) =>
      AppBar(title: Text(title));

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return UITextButton(
      label: 'Pop $id',
      onPressed: () {
        context.pop();
      },
    ).size(width: 200).center();
  }
}
