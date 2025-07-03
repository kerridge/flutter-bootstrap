import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/features/home/home.api.dart';
import 'package:template/features/todos/todos.api.dart';

final class AppGoRouter extends Notifier<GoRouter> {
  @override
  GoRouter build() {
    return _router;
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/todos',
            builder: (BuildContext context, GoRouterState state) {
              return const TodosPage();
            },
          ),
        ],
      ),
    ],
  );
}
