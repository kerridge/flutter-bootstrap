import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class ModuleRegistry {
  ModuleRegistry({required this.ref});

  static final provider = Provider<ModuleRegistry>((ref) {
    return ModuleRegistry(ref: ref);
  });

  final Ref ref;

  final Map<String, Module> _modules = {};
  final Map<String, Module> _rootModules = {};

  List<RouteBase> get routes {
    final routes = _modules.values.expand((m) => m.routes).toList();
    final settingsRoutes = _modules.values
        .expand((m) => m.settings.map((s) => s.route))
        .toList();

    return [...routes, ...settingsRoutes];
  }

  List<RouteBase> get rootRoutes {
    return _rootModules.values.expand((m) => m.routes).toList();
  }

  void register(Module module) {
    _modules.putIfAbsent(module.name, () => module);
  }

  void registerRootModule(Module module) {
    _rootModules.putIfAbsent(module.name, () => module);
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

abstract class SettingsMenuRepresentable<T extends RouteBase> {
  IconData? get icon;

  String get title;

  T get route;
}
