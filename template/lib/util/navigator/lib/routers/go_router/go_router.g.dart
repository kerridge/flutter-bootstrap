// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$myShellRouteData];

RouteBase get $myShellRouteData => StatefulShellRouteData.$route(
  restorationScopeId: MyShellRouteData.$restorationScopeId,
  navigatorContainerBuilder: MyShellRouteData.$navigatorContainerBuilder,
  factory: $MyShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [GoRouteData.$route(path: '/', factory: _$HomeRoute._fromState)],
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: BranchBData.$navigatorKey,
      restorationScopeId: BranchBData.$restorationScopeId,

      routes: [
        GoRouteData.$route(
          path: '/todos',

          factory: _$TodosListRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $MyShellRouteDataExtension on MyShellRouteData {
  static MyShellRouteData _fromState(GoRouterState state) =>
      const MyShellRouteData();
}

mixin _$HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TodosListRoute on GoRouteData {
  static TodosListRoute _fromState(GoRouterState state) =>
      const TodosListRoute();

  @override
  String get location => GoRouteData.$location('/todos');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
