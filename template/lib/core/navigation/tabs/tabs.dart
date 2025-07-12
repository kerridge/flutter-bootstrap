import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/modules/home/home.api.dart';
import 'package:template/modules/settings/lib/module/settings.routes.dart';
import 'package:template/modules/todos/todos.api.dart';
import 'package:template/util/navigation/navigation.api.dart';

abstract final class Tabs {
  static const HomeTab home = HomeTab();
  static const TodosTab todos = TodosTab();
  static const SettingsTab settings = SettingsTab();

  static List<TabData> get all {
    final tabs = [home, todos, settings];

    final indices = <int>{};
    for (final tab in tabs) {
      if (!indices.add(tab.index)) {
        throw RangeError.value(tab.index, 'index', 'Duplicate tab index found');
      }
    }

    return tabs;
  }
}

final class HomeTab extends TabData {
  const HomeTab();

  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>(
    debugLabel: 'home',
  );

  @override
  int get index => 0;

  @override
  String get name => 'Home';

  @override
  String get path => '/';

  @override
  IconData get icon => Icons.home;

  @override
  String get label => 'Home';

  @override
  StatefulShellBranch get branch => StatefulShellBranch(
    routes: <RouteBase>[HomeRoutes.homeroute],
    navigatorKey: _navKey,
  );
}

final class TodosTab extends TabData {
  const TodosTab();

  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>(
    debugLabel: 'todos',
  );

  @override
  int get index => 1;

  @override
  String get name => 'Todos';

  @override
  String get path => '/todos';

  @override
  IconData get icon => Icons.list;

  @override
  String get label => 'Todos';

  @override
  StatefulShellBranch get branch => StatefulShellBranch(
    routes: <RouteBase>[TodoRoutes.todosRoute],
    navigatorKey: _navKey,
  );
}

final class SettingsTab extends TabData {
  const SettingsTab();

  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>(
    debugLabel: 'settings',
  );

  @override
  int get index => 2;

  @override
  String get name => 'Settings';

  @override
  String get path => '/settings';

  @override
  IconData get icon => Icons.settings;

  @override
  String get label => 'Settings';

  @override
  StatefulShellBranch get branch => StatefulShellBranch(
    routes: <RouteBase>[SettingsRoutes.settingsRoute],
    navigatorKey: _navKey,
  );
}
