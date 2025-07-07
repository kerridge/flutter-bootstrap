import 'dart:async';

import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

class AuthRouteGuard extends GoRouteData {
  const AuthRouteGuard();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = false;

    if (!isAuthenticated) {
      return '/login';
    }

    return null;
  }
}
