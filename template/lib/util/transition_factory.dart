import 'package:flutter/material.dart';

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
