import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/app_shell.dart';
import 'tabs/tabs.dart';

final class AppRouter extends Notifier<GoRouter> {
  static final provider = NotifierProvider<AppRouter, GoRouter>(AppRouter.new);

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
    routes: <RouteBase>[_buildStatefulShell()],
  );

  StatefulShellRoute _buildStatefulShell() {
    final tabs = Tabs.all;

    return StatefulShellRoute.indexedStack(
      builder: (context, state, StatefulNavigationShell navigationShell) {
        return AppShell(shell: navigationShell, tabs: tabs);
      },
      branches: tabs.map((tab) => tab.branch).toList(),
    );
  }
}
