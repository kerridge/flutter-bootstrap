import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/util/navigation/navigation.api.dart';

import 'tab_bar.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.shell, required this.tabs});

  final StatefulNavigationShell shell;

  final List<TabData> tabs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: AppBottomNavigationBar(
        tabs: tabs,
        currentIndex: shell.currentIndex,
        onTabTap: (index) => _onTap(context, index),
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
