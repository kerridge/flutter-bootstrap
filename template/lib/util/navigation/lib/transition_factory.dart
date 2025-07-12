import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Enum for supported page transition types.
enum AppPageTransitionType {
  slideFade,
  // Add more types as needed
}

/// Factory for page transitions.
class TransitionFactory {
  static PageTransitionsBuilder getBuilder(AppPageTransitionType type) {
    switch (type) {
      case AppPageTransitionType.slideFade:
        return const _SlideFadePageTransitionsBuilder();
      // Add more cases as needed
    }
  }

  /// For use with CustomTransitionPage (GoRouter)
  static Widget transitionsBuilder(
    AppPageTransitionType type,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (type) {
      case AppPageTransitionType.slideFade:
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(0.3, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: FadeTransition(opacity: animation, child: child),
          ),
        );
    }
  }

  /// Creates a CustomTransitionPage with the specified transition type
  static CustomTransitionPage<T> createPage<T>({
    required AppPageTransitionType type,
    required Widget child,
    required String key,
    Duration? transitionDuration,
  }) {
    return CustomTransitionPage<T>(
      key: ValueKey(key),
      child: child,
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Only animate the incoming page, underlying page stays static
        return TransitionFactory.transitionsBuilder(
          type,
          context,
          animation,
          secondaryAnimation,
          child,
        );
      },
    );
  }
}

/// Optional: For use with MaterialPageRoute, etc.
class _SlideFadePageTransitionsBuilder extends PageTransitionsBuilder {
  const _SlideFadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return TransitionFactory.transitionsBuilder(
      AppPageTransitionType.slideFade,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
