import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/navigation/tabs/tabs.dart';
import 'package:template/util/module/module.dart';

import 'settings.routes.dart';

final class SettingsModule extends Module {
  static const GeneralSettingsItem _generalSettingsItem = GeneralSettingsItem();
  static const NotificationsSettingsItem _notificationsSettingsItem =
      NotificationsSettingsItem();

  @override
  String get name => 'settings';

  @override
  Future<void> initialize(Ref ref) async {}

  @override
  Map<AppTab, List<RouteBase>> get routes => {
    AppTab.settings: [
      GeneralSettingsRoute.route,
      NotificationsSettingsRoute.route,
    ],
  };

  @override
  List<SettingsMenuRepresentable> get settings => [
    _generalSettingsItem,
    _notificationsSettingsItem,
  ];
}

final class GeneralSettingsItem implements SettingsMenuRepresentable {
  const GeneralSettingsItem();

  @override
  IconData? get icon => Icons.settings;

  @override
  String get title => 'General';

  @override
  String get route => GeneralSettingsRoute().location;
}

final class NotificationsSettingsItem implements SettingsMenuRepresentable {
  const NotificationsSettingsItem();

  @override
  IconData? get icon => Icons.notifications;

  @override
  String get title => 'Notifications';

  @override
  String get route => NotificationsSettingsRoute().location;
}
