import 'package:template/util/navigation/navigation.api.dart';

import '../features/todo_detail/todo_detail_page.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import '../features/todos_list/todos_list_page.dart';

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

  static const String url = '/todos';

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return TransitionFactory.createPage(
      type: AppPageTransitionType.slideFade,
      child: const TodosListPage(),
      key: state.pageKey.toString(),
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class TodoDetailRoute extends GoRouteData with _$TodoDetailRoute {
  const TodoDetailRoute({required this.id});

  final String id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return TransitionFactory.createPage(
      type: AppPageTransitionType.slideFade,
      child: TodoDetailPage(id: id),
      key: state.pageKey.toString(),
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
