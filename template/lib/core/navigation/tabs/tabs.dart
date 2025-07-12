import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/modules/home/home.api.dart';
import 'package:template/modules/todos/todos.api.dart';
import 'package:template/util/navigation/navigation.api.dart';

abstract final class Tabs {
  static const HomeTab home = HomeTab();
  static const TodosTab todos = TodosTab();

  static List<TabData> get all {
    final tabs = [home, todos];

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
