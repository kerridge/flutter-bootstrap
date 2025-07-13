import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:template/core/navigation/app_router.dart';

import '../features/login/login_page.dart';
import '../features/signup/signup_page.dart';

part 'auth.routes.g.dart';

abstract final class AuthRoutes {
  static List<RouteBase> routes = $appRoutes;

  static LoginRoute get login => const LoginRoute();
  static final RouteBase loginRoute = $loginRoute;

  static SignupRoute get signup => const SignupRoute();
  static final RouteBase signupRoute = $signupRoute;
}

@TypedGoRoute<LoginRoute>(path: '/login', routes: [])
class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      AppRouter.rootNavKey;
}

@TypedGoRoute<SignupRoute>(path: '/signup', routes: [])
class SignupRoute extends GoRouteData with _$SignupRoute {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignupPage();
  }

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      AppRouter.rootNavKey;
}
