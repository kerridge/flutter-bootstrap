import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

part 'settings.routes.g.dart';

abstract final class SettingsRoutes {
  // static List<RouteBase> routes = $appRoutes;

  static SettingsRoute get settings => const SettingsRoute();

  static final RouteBase settingsRoute = $settingsRoute;
}

@TypedGoRoute<SettingsRoute>(path: '/settings', routes: [])
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Column(children: [Text('Settings')]);
  }
}
