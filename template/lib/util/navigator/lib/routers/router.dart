import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../module/providers.di.dart';
import '../screen_spec/screen_spec.api.dart';

abstract interface class AppRouter {
  void push(BuildContext context, String path);
  void pop(BuildContext context);

  void showBottomSheet(BuildContext context, WidgetBuilder builder);
  void displayDialog(BuildContext context, WidgetBuilder builder);
}

/// Widget that provides router access via dependOnWidgetOfExactType
class RouterWidget extends ConsumerWidget {
  const RouterWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _RouterInheritedWidget(
      router: ref.read(routerProvider),
      child: child,
    );
  }
}

/// Inherited widget that provides router access
class _RouterInheritedWidget extends InheritedWidget {
  const _RouterInheritedWidget({required this.router, required super.child});

  final AppRouter router;

  @override
  bool updateShouldNotify(_RouterInheritedWidget oldWidget) {
    return router != oldWidget.router;
  }

  static AppRouter of(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<_RouterInheritedWidget>();
    assert(widget != null, 'RouterWidget not found in widget tree');
    return widget!.router;
  }
}

extension RouterExtension on WidgetRef {
  AppRouter get router => read(routerProvider);
}

/// Extension to access router from any BuildContext
extension RouterContextExtension on BuildContext {
  AppRouter get router => _RouterInheritedWidget.of(this);
}
