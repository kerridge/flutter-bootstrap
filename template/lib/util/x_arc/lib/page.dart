import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/util/navigator/lib/routers/router.dart';

abstract class BasePage extends HookConsumerWidget {
  const BasePage({super.key});

  /// The title of the page
  @protected
  String get title;

  /// The path of the page
  @protected
  String get path;

  /// Called when the page is initialized
  @protected
  void onInit(BuildContext context, WidgetRef ref) {}

  /// Called when the page is disposed
  @protected
  void onDispose(BuildContext context, WidgetRef ref) {}

  /// Called when the page is resumed
  @protected
  void onResumed(BuildContext context, WidgetRef ref) {}

  /// Called when the page is paused
  @protected
  void onPaused(BuildContext context, WidgetRef ref) {}

  /// Called when the page is inactive
  @protected
  void onInactive(BuildContext context, WidgetRef ref) {}

  /// Called when the page is detached
  @protected
  void onDetached(BuildContext context, WidgetRef ref) {}

  /// Called when the page is hidden
  @protected
  void onHidden(BuildContext context, WidgetRef ref) {}

  /// Called when the page is will pop
  @protected
  void onWillPop(WidgetRef ref) {}

  /// Whether the page can be popped
  @protected
  bool get canPop => true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      onInit(context, ref);
      return () => onDispose(context, ref);
    }, []);

    useOnAppLifecycleStateChange((previousState, state) {
      switch (state) {
        case AppLifecycleState.resumed:
          onResumed(context, ref);
          break;
        case AppLifecycleState.paused:
          onPaused(context, ref);
          break;
        case AppLifecycleState.inactive:
          onInactive(context, ref);
          break;
        case AppLifecycleState.detached:
          onDetached(context, ref);
          break;
        case AppLifecycleState.hidden:
          onHidden(context, ref);
      }
    });

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        onWillPop(ref);
      },
      child: wrapWithSafeArea
          ? Container(
              color: unSafeAreaColor(context, ref),
              child: SafeArea(
                top: setTopSafeArea,
                bottom: setBottomSafeArea,
                child: _buildScaffold(context, ref),
              ),
            )
          : _buildScaffold(context, ref),
    );
  }

  Scaffold _buildScaffold(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: buildAppBar(context, ref, ref.router),
      body: buildContent(context, ref, ref.router),
      floatingActionButton: buildFloatingActionButton(ref),
      backgroundColor: screenBackgroundColor(context, ref),
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// The main content of the page
  @protected
  Widget buildContent(BuildContext context, WidgetRef ref, AppRouter router);

  /// The app bar of the page
  @protected
  PreferredSizeWidget? buildAppBar(
    BuildContext context,
    WidgetRef ref,
    AppRouter router,
  ) => null;

  /// The floating action button of the page
  @protected
  Widget? buildFloatingActionButton(WidgetRef ref) => null;

  /// The background color of the page
  @protected
  Color? screenBackgroundColor(BuildContext context, WidgetRef ref) =>
      Colors.white;

  /// Whether to wrap the page with safe area
  @protected
  bool get wrapWithSafeArea => true;

  /// Apply safe area on the bottom
  @protected
  bool get setBottomSafeArea => false;

  /// Apply safe area on the top
  @protected
  bool get setTopSafeArea => true;

  /// The color of the un-safe area
  @protected
  Color? unSafeAreaColor(BuildContext context, WidgetRef ref) => Colors.white;

  /// Whether to extend the body behind the app bar
  @protected
  bool get extendBodyBehindAppBar => false;

  /// Whether to resize the body to avoid the bottom inset
  @protected
  bool get resizeToAvoidBottomInset => false;
}
