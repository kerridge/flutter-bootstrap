import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:template/util/navigation/navigation.api.dart';

enum AppTab {
  home,
  todos,
  settings;

  TabData get tab => switch (this) {
    AppTab.home => Tabs.home,
    AppTab.todos => Tabs.todos,
    AppTab.settings => Tabs.settings,
  };

  GlobalKey<NavigatorState> get navigatorKey => switch (this) {
    AppTab.home => HomeTab.navKey,
    AppTab.todos => TodosTab.navKey,
    AppTab.settings => SettingsTab.navKey,
  };
}

abstract final class Tabs {
  static const HomeTab home = HomeTab();
  static const TodosTab todos = TodosTab();
  static const SettingsTab settings = SettingsTab();

  static List<TabData> get all {
    final tabs = [home, todos, settings];

    final indices = <int>{};
    for (final tab in tabs) {
      if (!indices.add(tab.order)) {
        throw RangeError.value(tab.order, 'index', 'Duplicate tab index found');
      }
    }

    return tabs.sorted((a, b) => a.order.compareTo(b.order));
  }
}

final class HomeTab extends TabData {
  const HomeTab();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>(
    debugLabel: 'home',
  );

  @override
  int get order => 0;

  @override
  String get name => 'Home';

  @override
  String get path => '/';

  @override
  IconData get icon => Icons.home;

  @override
  String get label => 'Home';
}

final class TodosTab extends TabData {
  const TodosTab();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>(
    debugLabel: 'todos',
  );

  @override
  int get order => 1;

  @override
  String get name => 'Todos';

  @override
  String get path => '/todos';

  @override
  IconData get icon => Icons.list;

  @override
  String get label => 'Todos';
}

final class SettingsTab extends TabData {
  const SettingsTab();

  static final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>(
    debugLabel: 'settings',
  );

  @override
  int get order => 2;

  @override
  String get name => 'Settings';

  @override
  String get path => '/settings';

  @override
  IconData get icon => Icons.settings;

  @override
  String get label => 'Settings';
}
