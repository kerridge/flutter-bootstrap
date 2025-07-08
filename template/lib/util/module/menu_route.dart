import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'module.dart';

part 'menu_route.g.dart';

@TypedGoRoute<TodoSettingsRoute>(
  path: '/todo-settings',
  routes: [TypedGoRoute<TodoSettingsDetailRoute>(path: ':id')],
)
final class TodoSettingsRoute extends GoRouteData with _$TodoSettingsRoute {}

final class TodoSettingsDetailRoute extends GoRouteData
    with _$TodoSettingsDetailRoute {
  TodoSettingsDetailRoute({required this.id});

  final String id;
}

final class TodoSettingsItem implements SettingsMenuRepresentable {
  TodoSettingsItem();

  @override
  IconData? get icon => Icons.list;

  @override
  String get title => 'Todo';

  @override
  RouteBase get route => $todoSettingsRoute;
}
