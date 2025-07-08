import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import '../features/home_page/home_page.dart';

part 'home.routes.g.dart';

abstract final class HomeRoutes {
  static List<RouteBase> routes = $appRoutes;

  static HomeRoute get home => const HomeRoute();
}

@TypedGoRoute<HomeRoute>(path: '/', routes: [])
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
