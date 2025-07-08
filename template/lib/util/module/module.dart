import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/util/module/menu_route.dart';
import 'package:template/util/navigator/lib/module/internal.di.dart';

final class ModuleRegistry {
  ModuleRegistry({required this.ref});

  static final provider = Provider<ModuleRegistry>((ref) {
    return ModuleRegistry(ref: ref);
  });

  final Ref ref;

  final Map<String, Module> _modules = {};

  List<RouteBase> get routes {
    final routes = _modules.values.expand((m) => m.routes).toList();
    final settingsRoutes = _modules.values
        .expand((m) => m.settings.map((s) => s.route))
        .toList();

    return [...routes, ...settingsRoutes];
  }

  void register(Module module) {
    _modules.putIfAbsent(module.name, () => module);
  }

  Module? get(String name) {
    return _modules[name];
  }

  Future<void> initialize() async {
    for (final module in _modules.values) {
      await module.initialize(ref);
    }
  }
}

abstract class Module {
  String get name;

  List<RouteBase> get routes => [];

  List<SettingsMenuRepresentable> get settings => [];

  Future<void> initialize(Ref ref) async {}
}

final class TodoModule extends Module {
  @override
  String get name => 'todo';

  @override
  List<RouteBase> get routes => [];

  @override
  Future<void> initialize(Ref ref) async {}

  @override
  List<SettingsMenuRepresentable> get settings => [TodoSettingsItem()];
}

abstract class SettingsMenuRepresentable<T extends RouteBase> {
  IconData? get icon;

  String get title;

  T get route;
}
