import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/modules/home/home.api.dart';
import 'package:template/modules/todos/todos.api.dart';

final class AppGoRouter extends Notifier<GoRouter> {
  static final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>(
    debugLabel: 'root',
  );

  @override
  GoRouter build() {
    return _router;
  }

  late final GoRouter _router = GoRouter(
    navigatorKey: rootNavKey,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: <RouteBase>[_buildStatefulShellRoutes()],
  );
}

abstract final class Tab {
  const Tab();

  String get name;

  String get path;

  IconData get icon;

  String get label;

  StatefulShellBranch get branch;
}

final class HomeTab extends Tab {
  const HomeTab();

  @override
  String get name => 'Home';

  @override
  String get path => '/';

  @override
  IconData get icon => Icons.home;

  @override
  String get label => 'Home';

  @override
  StatefulShellBranch get branch =>
      StatefulShellBranch(routes: <RouteBase>[HomeRoutes.homeroute]);
}

final class TodosTab extends Tab {
  const TodosTab();

  @override
  String get name => 'Todos';

  @override
  String get path => '/todos';

  @override
  IconData get icon => Icons.list;

  @override
  String get label => 'Todos';

  @override
  StatefulShellBranch get branch =>
      StatefulShellBranch(routes: <RouteBase>[TodoRoutes.todosRoute]);
}

StatefulShellRoute _buildStatefulShellRoutes() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, StatefulNavigationShell navigationShell) {
      return AppShell(shell: navigationShell, children: []);
    },
    branches: _tabs.map((tab) => tab.branch).toList(),
  );
}

const List<Tab> _tabs = [HomeTab(), TodosTab()];

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell, required this.children});

  final StatefulNavigationShell shell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBranchContainer(
        currentIndex: shell.currentIndex,
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
        ],
        currentIndex: shell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    shell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == shell.currentIndex,
    );
  }
}

/// Custom branch Navigator container that provides animated transitions
/// when switching branches.
class AnimatedBranchContainer extends StatelessWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: children.mapIndexed((int index, Widget navigator) {
        return AnimatedScale(
          scale: index == currentIndex ? 1 : 1.5,
          duration: const Duration(milliseconds: 400),
          child: AnimatedOpacity(
            opacity: index == currentIndex ? 1 : 0,
            duration: const Duration(milliseconds: 400),
            child: _branchNavigatorWrapper(index, navigator),
          ),
        );
      }).toList(),
    );
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
    ignoring: index != currentIndex,
    child: TickerMode(enabled: index == currentIndex, child: navigator),
  );
}
