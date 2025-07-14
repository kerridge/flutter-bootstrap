import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/navigation/tabs/tabs.dart';
import 'package:template/util/module/module.dart';

import 'settings.routes.dart';

final class SettingsModule extends Module {
  static const GeneralSettingsItem _generalSettingsItem = GeneralSettingsItem();

  @override
  String get name => 'settings';

  @override
  Future<void> initialize(Ref ref) async {}

  @override
  Map<AppTab, List<RouteBase>> get routes => {
    AppTab.settings: [_generalSettingsItem.route],
  };

  @override
  List<SettingsMenuRepresentable> get settings => [_generalSettingsItem];
}

final class GeneralSettingsItem implements SettingsMenuRepresentable {
  const GeneralSettingsItem();

  @override
  IconData? get icon => Icons.settings;

  @override
  String get title => 'General';

  @override
  RouteBase get route => SettingsRoutes.generalSettingsRoute;
}
