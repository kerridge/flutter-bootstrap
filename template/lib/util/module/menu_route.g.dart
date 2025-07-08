// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$todoSettingsRoute];

RouteBase get $todoSettingsRoute => GoRouteData.$route(
  path: '/todo-settings',

  factory: _$TodoSettingsRoute._fromState,
  routes: [
    GoRouteData.$route(
      path: ':id',

      factory: _$TodoSettingsDetailRoute._fromState,
    ),
  ],
);

mixin _$TodoSettingsRoute on GoRouteData {
  static TodoSettingsRoute _fromState(GoRouterState state) =>
      TodoSettingsRoute();

  @override
  String get location => GoRouteData.$location('/todo-settings');

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

mixin _$TodoSettingsDetailRoute on GoRouteData {
  static TodoSettingsDetailRoute _fromState(GoRouterState state) =>
      TodoSettingsDetailRoute(id: state.pathParameters['id']!);

  TodoSettingsDetailRoute get _self => this as TodoSettingsDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/todo-settings/${Uri.encodeComponent(_self.id)}');

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
