import 'package:go_router/go_router.dart';
import 'package:template/util/module/module.dart';

import 'auth.routes.dart';

final class AuthModule extends Module {
  @override
  String get name => 'auth';

  @override
  List<RouteBase> get routes => AuthRoutes.routes;

  @override
  List<SettingsMenuRepresentable> get settings => [];
}
