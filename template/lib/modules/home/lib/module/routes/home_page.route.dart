import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import '../../features/home_page/home_page.dart';

part 'home_page.route.g.dart';

@TypedGoRoute<HomeRoute>(path: '/', routes: [])
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();
}
