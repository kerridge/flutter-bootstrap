import 'package:go_router/go_router.dart';
import 'package:template/util/module/module.dart';

import 'auth.routes.dart';

final class AuthModule extends RootModule {
  @override
  String get name => 'auth';

  @override
  List<RouteBase> get routes => AuthRoutes.routes;
}
