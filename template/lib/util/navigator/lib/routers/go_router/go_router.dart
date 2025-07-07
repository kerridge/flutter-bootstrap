import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/modules/home/home.api.dart';
import 'package:template/modules/todos/todos.api.dart';
import 'package:template/modules/todos/lib/features/todo_detail/todo_page.dart';

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
            path: 'todos',
            builder: (BuildContext context, GoRouterState state) {
              return const TodosPage();
            },
          ),
          GoRoute(
            path: 'todo/:id',
            builder: (BuildContext context, GoRouterState state) {
              final id = state.pathParameters['id'] ?? '';
              return TodoPage();
            },
          ),
        ],
      ),
    ],
  );
}
