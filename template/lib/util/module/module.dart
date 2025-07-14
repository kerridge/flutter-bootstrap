import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:template/core/navigation/tabs/tabs.dart';

final class ModuleRegistry {
  ModuleRegistry(this.ref);

  static final provider = Provider<ModuleRegistry>(ModuleRegistry.new);

  final Ref ref;

  final Map<String, Module> _modules = {};
  final Map<String, RootModule> _rootModules = {};

  Map<AppTab, List<RouteBase>> get routes {
    final routes = <AppTab, List<RouteBase>>{};

    for (final module in _modules.values) {
      for (final routesEntry in module.routes.entries) {
        final routesForTab = routesEntry.value;
        final tab = routesEntry.key;

        routes[tab] = [...routes[tab] ?? [], ...routesForTab];
      }
    }

    return routes;
  }

  List<RouteBase> get rootRoutes {
    return _rootModules.values.expand((m) => m.routes).toList();
  }

  Map<String, List<SettingsMenuRepresentable>> get settings {
    final Map<String, List<SettingsMenuRepresentable>> result = {};

    for (final module in _modules.values) {
      if (module.settings.isNotEmpty) {
        result[module.name] = module.settings;
      }
    }

    return result;
  }

  void register(Module module) {
    _modules.putIfAbsent(module.name, () => module);
  }

  void registerRootModule(RootModule module) {
    _rootModules.putIfAbsent(module.name, () => module);
  }

  Future<void> initialize() async {
    for (final module in _modules.values) {
      await module.initialize(ref);
    }
  }
}

abstract class Module extends ModuleBase {
  Map<AppTab, List<RouteBase>> get routes => {};

  List<SettingsMenuRepresentable> get settings => [];
}

abstract class RootModule extends ModuleBase {
  List<RouteBase> get routes => [];
}

abstract class ModuleBase {
  String get name;

  Future<void> initialize(Ref ref) async {}
}

abstract class SettingsMenuRepresentable {
  IconData? get icon;

  String get title;

  String get route;
}
