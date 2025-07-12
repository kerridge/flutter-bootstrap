import '../features/todo_detail/todo_detail_page.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import '../features/todos_list/todos_list_page.dart';

import 'package:template/util/transition_factory.dart';

part 'todo.routes.g.dart';

abstract final class TodoRoutes {
  static List<RouteBase> routes = $appRoutes;

  static const TodosListRoute todosList = TodosListRoute();
  static TodoDetailRoute todoDetail(String id) => TodoDetailRoute(id: id);

  static final RouteBase todosRoute = $todosListRoute;
}

@TypedGoRoute<TodosListRoute>(
  path: '/todos',
  routes: [TypedGoRoute<TodoDetailRoute>(path: ':id', routes: [])],
)
class TodosListRoute extends GoRouteData with _$TodosListRoute {
  const TodosListRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: const TodosListPage(),
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return TransitionFactory.transitionsBuilder(
          AppPageTransitionType.slideFade,
          context,
          animation,
          secondaryAnimation,
          child,
        );
      },
    );
  }
}

class TodoDetailRoute extends GoRouteData with _$TodoDetailRoute {
  const TodoDetailRoute({required this.id});

  final String id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: TodoDetailPage(id: id),
      transitionDuration: const Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return TransitionFactory.transitionsBuilder(
          AppPageTransitionType.slideFade,
          context,
          animation,
          secondaryAnimation,
          child,
        );
      },
    );
  }
}
