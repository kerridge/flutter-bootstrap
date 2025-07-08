import '../features/todo_detail/todo_detail_page.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';

import '../features/todos_list/todos_list_page.dart';

part 'todo.routes.g.dart';

abstract final class TodoRoutes {
  static List<RouteBase> routes = $appRoutes;

  static TodosListRoute get todosList => const TodosListRoute();
  static TodoDetailRoute todoDetail(String id) => TodoDetailRoute(id: id);
}

@TypedGoRoute<TodosListRoute>(
  path: '/todos',
  routes: [TypedGoRoute<TodoDetailRoute>(path: ':id', routes: [])],
)
class TodosListRoute extends GoRouteData with _$TodosListRoute {
  const TodosListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodosListPage();
  }
}

class TodoDetailRoute extends GoRouteData with _$TodoDetailRoute {
  const TodoDetailRoute({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TodoDetailPage(id: id);
  }
}
