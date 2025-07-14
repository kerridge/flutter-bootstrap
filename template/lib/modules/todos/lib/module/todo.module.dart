import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/navigation/tabs/tabs.dart';
import 'package:template/util/module/module.dart';

import 'todo.routes.dart';

final class TodoModule extends Module {
  @override
  String get name => 'todos';

  @override
  Future<void> initialize(Ref ref) async {}

  @override
  Map<AppTab, List<RouteBase>> get routes => {
    AppTab.todos: [TodoRoutes.todosRoute],
  };

  @override
  List<SettingsMenuRepresentable> get settings => [];
}
