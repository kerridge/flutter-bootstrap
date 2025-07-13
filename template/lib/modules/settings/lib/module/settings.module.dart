import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/util/module/module.dart';

import 'settings.routes.dart';

final class SettingsModule extends Module {
  @override
  String get name => 'settings';

  @override
  Future<void> initialize(Ref ref) async {}

  @override
  List<RouteBase> get routes => [];

  @override
  List<SettingsMenuRepresentable> get settings => [AppSettingsItem()];
}

final class AppSettingsItem implements SettingsMenuRepresentable {
  AppSettingsItem();

  @override
  IconData? get icon => Icons.settings;

  @override
  String get title => 'General';

  @override
  RouteBase get route => SettingsRoutes.settingsRoute;
}
