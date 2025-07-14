import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/navigation/tabs/tabs.dart';
import 'package:template/util/module/module.dart';

import 'home.routes.dart';

final class HomeModule extends Module {
  @override
  String get name => 'home';

  @override
  Future<void> initialize(Ref ref) async {}

  @override
  Map<AppTab, List<RouteBase>> get routes => {
    AppTab.home: [HomeRoutes.homeRoute],
  };

  @override
  List<SettingsMenuRepresentable> get settings => [];
}
