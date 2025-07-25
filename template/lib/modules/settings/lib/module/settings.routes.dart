import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import '../view/features/app_settings/app_settings_page.dart';

part 'settings.routes.g.dart';

abstract final class SettingsRoutes {
  // static List<RouteBase> routes = $appRoutes;

  static SettingsRoute get settings => const SettingsRoute();

  static final RouteBase settingsRoute = $settingsRoute;

  static final RouteBase generalSettingsRoute = $generalSettingsRoute;
}

@TypedGoRoute<SettingsRoute>(path: '/settings', routes: [])
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Column(children: [Text('Settings')]);
  }
}

@TypedGoRoute<GeneralSettingsRoute>(path: '/settings/general', routes: [])
class GeneralSettingsRoute extends GoRouteData with _$GeneralSettingsRoute {
  const GeneralSettingsRoute();

  static final RouteBase route = $generalSettingsRoute;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppSettingsPage();
  }
}

@TypedGoRoute<NotificationsSettingsRoute>(
  path: '/settings/notifications',
  routes: [],
)
class NotificationsSettingsRoute extends GoRouteData
    with _$NotificationsSettingsRoute {
  const NotificationsSettingsRoute();

  static final RouteBase route = $notificationsSettingsRoute;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AppSettingsPage();
  }
}
