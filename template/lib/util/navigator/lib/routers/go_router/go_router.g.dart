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
      restorationScopeId: BranchAData.$restorationScopeId,
    ),
    StatefulShellBranchData.$branch(
      navigatorKey: BranchBData.$navigatorKey,
      restorationScopeId: BranchBData.$restorationScopeId,
      preload: BranchBData.$preload,
    ),
  ],
);

extension $MyShellRouteDataExtension on MyShellRouteData {
  static MyShellRouteData _fromState(GoRouterState state) =>
      const MyShellRouteData();
}
