// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$todosListRoute];

RouteBase get $todosListRoute => GoRouteData.$route(
  path: '/todos',

  factory: _$TodosListRoute._fromState,
  routes: [
    GoRouteData.$route(path: ':id', factory: _$TodoDetailRoute._fromState),
  ],
);

mixin _$TodosListRoute on GoRouteData {
  static TodosListRoute _fromState(GoRouterState state) =>
      const TodosListRoute();

  @override
  String get location => GoRouteData.$location('/todos');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TodoDetailRoute on GoRouteData {
  static TodoDetailRoute _fromState(GoRouterState state) =>
      TodoDetailRoute(id: state.pathParameters['id']!);

  TodoDetailRoute get _self => this as TodoDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/todos/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
