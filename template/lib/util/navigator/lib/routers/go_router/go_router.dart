import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>(
    debugLabel: 'home',
  );

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
    routes: <RouteBase>[HomeRoutes.homeRoute],
    navigatorKey: _navKey,
  );
}

final class TodosTab extends Tab {
  const TodosTab();

  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>(
    debugLabel: 'todos',
  );

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

StatefulShellRoute _buildStatefulShellRoutes() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, StatefulNavigationShell navigationShell) {
      return AppShell(shell: navigationShell);
    },
    branches: _tabs.map((tab) => tab.branch).toList(),
  );
}

const List<Tab> _tabs = [HomeTab(), TodosTab()];

class AppShell extends HookConsumerWidget {
  const AppShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final previousIndex = usePrevious(shell.currentIndex);
    final isTransitioning = useState(false);

    useEffect(() {
      if (previousIndex != null && previousIndex != shell.currentIndex) {
        isTransitioning.value = true;
        Future.delayed(const Duration(milliseconds: 300), () {
          isTransitioning.value = false;
        });
      }
      return null;
    }, [shell.currentIndex]);

    return Scaffold(
      body: AnimatedSwitcher(
        key: ValueKey(shell.currentIndex),
        duration: const Duration(milliseconds: 3000),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(0.1, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  ),
              child: child,
            ),
          );
        },
        child: shell,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _tabs.mapIndexed((index, tab) {
                final isSelected = index == shell.currentIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onTap(context, index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected
                            ? Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1)
                            : Colors.transparent,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            tab.icon,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.6),
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tab.label,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(height: 4),
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
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
